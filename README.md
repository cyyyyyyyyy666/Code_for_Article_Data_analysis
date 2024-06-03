# README

## Project Title: Investigating the Causal Relationship Between Gut Microbiota and Acute Pancreatitis

### Abstract

**Background:**  
Gut microbiota may influence the pathogenesis of acute pancreatitis (AP), a serious gastrointestinal disease with high morbidity and mortality. This study aimed to identify a causal link by investigating the intricate relationship between gut microbiota and AP.

**Methods:**  
We integrated Mendelian randomisation (MR) methods with a nested case-control study to explore potential associations between microbiota composition and AP. This multi-faceted analytical approach included MR, 16S rRNA sequencing analysis, random forest modelling (RF), support vector machine (SVM), and Kaplan–Meier survival assessment, pinpointing significant gut microbiota and revealing their correlations with the hospitalisation duration of patients with AP.

**Results:**  
Our bidirectional MR results confirmed a causal link between specific gut microbiota and AP, identifying 15 and 8 microbial taxa via forward and reverse MR, respectively. The 16S rRNA sequencing analysis demonstrated a pronounced difference in microbiota composition between cases and controls. Notably, after a comprehensive evaluation of RF and SVM results, Bacteroides plebeius was found to play a significant role in influencing hospital status. Using a receiver operating characteristic (ROC) curve, we determined the predictive power (0.757) of B. plebeius. Kaplan–Meier survival analysis offered further insight, showing that patients with an elevated abundance of B. plebeius experienced prolonged hospital stays.

**Conclusions:**  
By combining MR with nested case-control studies, our research provides a detailed characterisation of the interactions between gut microbiota and AP. We identified B. plebeius as an important contributor, revealing its potential as both a precursor and a consequence of the dynamics of AP. Furthermore, our insights into changes in the gut microbiota emphasise the multifactorial nature of AP and its complex relationship with the internal microbial ecosystem. This study lays the foundation for future exploration of innovative therapeutic interventions targeting these microbial dynamics in the treatment of AP.

### Repository Contents

This repository contains the following materials:

1. **R Scripts**: All R scripts used for the MR analysis, random forest modelling, support vector machine analysis, and Kaplan–Meier survival assessment.
2. **Data Files**: Raw and processed data files used in the study.
3. **Supplementary Information**: Supplementary tables and figures referenced in the manuscript.
4. **Figures**: High-resolution images of all figures included in the manuscript.

### Installation

To run the analyses included in this repository, you will need the following R packages:
- `MendelianRandomization`
- `MRPRESSO`
- `qiime2`
- `ggtree`
- `glmnet`
- `caret`
- `randomForest`

These can be installed in R using the `install.packages` function:

```R
install.packages(c("MendelianRandomization", "MRPRESSO", "qiime2", "ggtree", "glmnet", "caret", "randomForest"))
```

### Usage

1. **Clone the repository**:
   ```sh
   git clone https://github.com/cyyyyyyyyy666/Code_for_Article_Data_analysis
   cd Code_for_Article_Data_analysis

   ```

2. **Run the analysis**:
   Open the R scripts in your R environment and run them sequentially. Ensure that the data files are in the correct directory as specified in the scripts.

### Contributions

If you wish to contribute to this project, please fork the repository and create a pull request with your modifications. Ensure that your contributions adhere to the coding and data standards outlined in this repository.

### Acknowledgements

We thank the reviewers for their constructive feedback, which has significantly improved the quality and rigor of our research.

For further questions or inquiries, please contact [feili36@ccmu.edu.cn].

---

This README file provides comprehensive instructions and information for replicating the study, ensuring that other researchers can effectively use the materials and methods described.
