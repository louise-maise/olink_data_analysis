library(tidyverse)
library(survival)
library(survminer)

# Load glioblastoma data clean_w_binary_2: including the 2 different binary variables
glioblastoma_data_clean_extended <- readRDS("input/glioblastoma_data_clean_extended.rds")
glioblastoma_data_clean_extended$CSF_1_binary_median

# Option 1: Cut-off median of all 30 Glioblastoma patients only#####################
# List of variable names
variable_names <- c("CXCL11_binary_median", "CD83_binary_median", "IL8_binary_median", "TNFRSF9_binary_median", "TIE2_binary_median", "MCP_3_binary_median", #"CD40_L_binary_median",
                    "IL_1_alpha_binary_median", 
                    "CD244_binary_median", "EGF_binary_median", "ANG_1_binary_median", "IL7_binary_median", "PGF_binary_median", "IL6_binary_median", "ADGRG1_binary_median", 
                    "MCP_1_binary_median", "MCP_4_binary_median", "TRAIL_binary_median", "FGF2_binary_median", "CXCL9_binary_median", "CD8A_binary_median",
                    "CAIX_binary_median", "ADA_binary_median", "CD4_binary_median", "NOS3_binary_median", "Gal_9_binary_median",
                    "VEGFR2_binary_median", "CD40_binary_median", "IL18_binary_median", "GZMH_binary_median", "VEGFC_binary_median", "LAP_TGF_beta_1_binary_median",
                    "CXCL1_binary_median", "TNFSF14_binary_median", "IL33_binary_median", "TWEAK_binary_median", "PDGF subunit B_binary_median",
                    "FASLG_binary_median", "CCL19_binary_median", "MCP_2_binary_median", "CCL4_binary_median", "Gal_1_binary_median",
                    "PDL1_binary_median", "CD27_binary_median", "CXCL5_binary_median", "HGF_binary_median", "GZMA_binary_median", "HO_1_binary_median",
                    "CX3CL1_binary_median", "CXCL10_binary_median", "CD70_binary_median", "TNFRSF12A_binary_median", "CCL23_binary_median",
                    "CD5_binary_median", "CCL3_binary_median", "MMP7_binary_median", "ARG1_binary_median", "DCN_binary_median", "TNFRSF21_binary_median",
                    "TNFRSF4_binary_median", "MIC_A_B_binary_median", "CCL17_binary_median", "ANGPT2_binary_median", "PTN_binary_median",
                    "LAMP3_binary_median", "CASP_8_binary_median", "ICOSLG_binary_median", "MMP12_binary_median", "CXCL13_binary_median",
                    "VEGFA_binary_median", "IL12RB1_binary_median", "CCL20_binary_median",
                    "GZMB_binary_median", "IL12_binary_median", "CSF_1_binary_median")

## Overall Survival: Kaplan Meier curves and Log-rank tests for proteins of interest
### Create a list to store the plots
plot_list_os <- list()

### Loop through each variable
for (variable in variable_names) {
  # Fit the survival model
  km_fit <- survfit(Surv(os_in_months, censor_os) ~ get(variable), 
                    data = glioblastoma_data_clean_extended)
  
  # Generate the plot
  ggsurv_plot <- ggsurvplot(
    km_fit,
    data = glioblastoma_data_clean_extended,
    risk.table = TRUE,
    pval = TRUE,
    pval.method = TRUE,
    pval.method.coord = c(0, 0.25),
    pval.coord = c(0, 0.15),
    conf.int = FALSE,
    palette = "jco",
    legend.title = "Legend",
    legend.labs = c(paste(variable, "Low"), paste(variable, "High"))
  ) +
    ggtitle(paste("Overall Survival stratified by", variable, "Cut-off Median glioblastoma pat."))
  
  # Modify theme
  ggsurv_plot$plot <- ggsurv_plot$plot +
    theme(
      legend.position = c(0.8, 0.8),
      legend.box.just = "right",
      legend.margin = margin(5, 5, 5, 5),
      legend.text = element_text(size = 12),
      legend.title = element_text(size = 12, face = "bold")
    )
  
  # Store the plot in the list
  plot_list_os[[variable]] <- ggsurv_plot
}

### Print the plots
for (variable in variable_names) {
  print(plot_list_os[[variable]])
}


## Progression-free Survival: Kaplan Meier curves and Log-rank tests for proteins of interest
### Create a list to store the plots
plot_list_pfs <- list()
### Loop through each variable
for (variable in variable_names) {
  # Fit the survival model
  km_fit <- survfit(Surv(pfs_in_months, censor_pfs) ~ get(variable), data = glioblastoma_data_clean_extended)
  
  # Generate the plot
  ggsurv_plot <- ggsurvplot(
    km_fit,
    data = glioblastoma_data_clean_extended,
    risk.table = TRUE,
    pval = TRUE,
    pval.method = TRUE,
    pval.method.coord = c(0, 0.25),
    pval.coord = c(0, 0.15),
    conf.int = FALSE,
    palette = "jco",
    legend.title = "Legend",
    legend.labs = c(paste(variable, "Low"), paste(variable, "High"))
  ) +
    ggtitle(paste("Progression-free Survival stratified by", variable, "Cut-off Median glioblastoma pat."))
  
  # Modify theme
  ggsurv_plot$plot <- ggsurv_plot$plot +
    theme(
      legend.position = c(0.8, 0.8),
      legend.box.just = "right",
      legend.margin = margin(5, 5, 5, 5),
      legend.text = element_text(size = 12),
      legend.title = element_text(size = 12, face = "bold")
    )
  
  # Store the plot in the list
  plot_list_pfs[[variable]] <- ggsurv_plot
}

### Print the plots
for (variable in variable_names) {
  print(plot_list_pfs[[variable]])
}
