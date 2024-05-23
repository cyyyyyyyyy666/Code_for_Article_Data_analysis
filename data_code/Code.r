#* ---install or library-------------------------------------
if (!require("devtools")) { install.packages("devtools") } else {}
if (!require("data.table")) { install.packages("data.table") } else {}
if (!require("TwoSampleMR")) { devtools::install_github("MRCIEU/TwoSampleMR") } else {}
if (!require("MRInstruments")) { devtools::install_github("MRCIEU/MRInstruments") } else {}
library(MRInstruments)
library(plyr)
library(dplyr)  


FileNames<-list.files(paste0(getwd()),pattern=".txt")

#* ---Set working directory-------------------------------------
`%+%` <- function(x,y) paste0(x,y)
dir.create(getwd()%+%"/data")  
path_data <- getwd()%+%"/data"
dir.create(getwd()%+%"/result")
path_res <- getwd()%+%"/result"

for(i in c(1:length(FileNames))){
  d1<- try(fread(paste0(getwd(),"/",FileNames[i]),sep = "\t"),silent = T)
  d2<-subset(d1,d1$P.weightedSumZ<1e-5)
  d3<-d2[,c(1,4,5,6,7,8,10,11)]
write.table(d3,paste0(path_data,"/",FileNames[i]),sep=",", col.names = T, row.names = F, quote = F)}

#* ---export IVs-------------------------------------
exp_dat <- list()
ex_pore <- c()
for(i in c(1:length(FileNames))){
   IV <- fread(paste0(path_data,"/",FileNames[i]))
   IV$PHENO <- FileNames[i]
   IV1<-format_data(IV,
                         type="exposure",
                         phenotype_col = "PHENO",
                         snp_col = "rsID",
                         beta_col = "beta",
                         se_col = "SE",
                         pval_col = "P.weightedSumZ",
                         samplesize_col = "N",
                         effect_allele_col = "eff.allele",
                         other_allele_col = "ref.allele")
   IV1 <- clump_data(IV1,clump_kb = 500,clump_r2 = 0.1)
   exp_dat[[i]] <- IV1
   ex_pore<-c(ex_pore,FileNames[i])
}

##Outcome data
dataname1="D:/Codeprogram/overall.tsv"
GWAS_1 <- fread(dataname1)
allSNP  <- do.call(rbind, exp_dat)
GWAS_2 <- subset(GWAS_1,GWAS_1$variant_id %in% allSNP$SNP)
rm(GWAS_1)
GWAS_2$PHENO<-"cancer"
out_data     <- format_data(GWAS_2,
                           type="outcome",
                           phenotype_col = "PHENO",
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p_value",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",)

out_dat <- list()
out_dat[[1]] <- out_data

#define the circle  ################
out_come<-c("cancer")
#####################

save.image("IV_SETUP.Rdata")
load("IV_SETUP.Rdata")


######################
results <- list()


for (i in c(1:length(ex_pore))){
  for (j in c(1:length(out_come))){
    dat <- harmonise_data(
      exposure_dat = exp_dat[[i]],
      outcome_dat = out_dat[[j]],
      action = 2
    )
    
    res <- mr(dat)
    res$exposure=ex_pore[i]
    res$outcome=out_come[j]
    print(paste0("------", ex_pore[i], " & ",out_come[j],"------"))
    
    print(generate_odds_ratios(res))
    
    #primary results
    results[[length(out_come)*(i-1)+j]]    <- generate_odds_ratios(res)
  }
}



results_allIV  <- do.call(rbind, results)
#format(round(x, 2), nsmall = 2)
results_allIV$estimate <- paste0(format(round(results_allIV$or, 2), nsmall = 2), " (", 
                                 format(round(results_allIV$or_lci95, 2), nsmall = 2), "-",
                                 format(round(results_allIV$or_uci95, 2), nsmall = 2), ")")

row_x <- rownames (results_allIV[which(results_allIV$pval > 0.05), ])

results_allIV$pvalue          <- format(results_allIV$pval, scientific = TRUE, digits = 2)
results_allIV[row_x, ]$pvalue <- format(round(results_allIV[row_x, ]$pval, 2), nsmall = 2)


###################### output ###############
outname1="/results.csv"
write.table(results_allIV[,c(3:ncol(results_allIV))],path_res%+%outname1,sep = ",",row.names =FALSE,col.names =TRUE,quote =TRUE)

