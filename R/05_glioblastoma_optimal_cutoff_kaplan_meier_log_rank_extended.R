library(tidyverse)
library(survival)
library(survminer)

# Load glioblastoma data clean_w_binary_2: including the 2 different binary variables
glioblastoma_data_clean_extended <- readRDS("input/glioblastoma_data_clean_extended.rds")

# Option 1: Cut-off median of all 30 Glioblastoma patients only#####################
# List of variable names
variable_names <- c("CXCL11_binary_optimal", "CD83_binary_optimal", "IL8_binary_optimal", "TNFRSF9_binary_optimal", "TIE2_binary_optimal", "MCP_3_binary_optimal", "CD40_L_binary_optimal", "IL_1_alpha_binary_optimal", 
                                    "CD244_binary_optimal", "EGF_binary_optimal", "ANG_1_binary_optimal", "IL7_binary_optimal", "PGF_binary_optimal", "IL6_binary_optimal", "ADGRG1_binary_optimal", 
                                    "MCP_1_binary_optimal", "MCP_4_binary_optimal", "TRAIL_binary_optimal", "FGF2_binary_optimal", "CXCL9_binary_optimal", "CD8A_binary_optimal",
                                    "CAIX_binary_optimal", "ADA_binary_optimal", "CD4_binary_optimal", "NOS3_binary_optimal", "Gal_9_binary_optimal",
                                    "VEGFR2_binary_optimal", "CD40_binary_optimal", "IL18_binary_optimal", "GZMH_binary_optimal", "VEGFC_binary_optimal", "LAP_TGF_beta_1_binary_optimal",
                                    "CXCL1_binary_optimal", "TNFSF14_binary_optimal", "IL33_binary_optimal", "TWEAK_binary_optimal", "PDGF subunit B_binary_optimal", "PDCD1_binary_optimal",
                                    "FASLG_binary_optimal", "CD28_binary_optimal", "CCL19_binary_optimal", "MCP_2_binary_optimal", "CCL4_binary_optimal", "Gal_1_binary_optimal",
                                    "PDL1_binary_optimal", "CD27_binary_optimal", "CXCL5_binary_optimal", "HGF_binary_optimal", "GZMA_binary_optimal", "HO_1_binary_optimal",
                                    "CX3CL1_binary_optimal", "CXCL10_binary_optimal", "CD70_binary_optimal", "TNFRSF12A_binary_optimal", "CCL23_binary_optimal",
                                    "CD5_binary_optimal", "CCL3_binary_optimal", "MMP7_binary_optimal", "ARG1_binary_optimal", "DCN_binary_optimal", "TNFRSF21_binary_optimal",
                                    "TNFRSF4_binary_optimal", "MIC_A_B_binary_optimal", "CCL17_binary_optimal", "ANGPT2_binary_optimal", "PTN_binary_optimal", "CXCL12_binary_optimal",
                                    "LAMP3_binary_optimal", "CASP_8_binary_optimal", "ICOSLG_binary_optimal", "MMP12_binary_optimal", "CXCL13_binary_optimal",
                                    "PD_L2_binary_optimal", "VEGFA_binary_optimal", "IL4_binary_optimal", "IL12RB1_binary_optimal", "CCL20_binary_optimal",
                                    "KLRD1_binary_optimal", "GZMB_binary_optimal", "IL12_binary_optimal", "CSF_1_binary_optimal")

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
