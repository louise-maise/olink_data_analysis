library(tidyverse)
library(survival)
library(survminer)

# Load glioblastoma data clean_w_binary_2: including the 2 different binary variables
glioblastoma_data_complete <- readRDS("input/glioblastoma_data_complete.rds")
str(glioblastoma_data_complete)

# Cut-off optimal as calculated by  all 30 Glioblastoma patients only#####################
# List of variable names
variable_names <- c("CXCL11_binary_optimal", "CD83_binary_optimal", "CD40_binary_optimal", 
                    "CD5_binary_optimal", "LAP_TGF_beta_1_binary_optimal", "VEGFA_binary_optimal",
                    "PDL1_binary_optimal", "CD244_binary_optimal", "IL6_binary_optimal", "IL8_binary_optimal", 
                    "CXCL9_binary_optimal")

## Overall Survival: Kaplan Meier curves and Log-rank tests for proteins of interest
### Create a list to store the plots
plot_list_os <- list()
### Loop through each variable
for (variable in variable_names) {
  # Fit the survival model
  km_fit <- survfit(Surv(os_in_months, censor_os) ~ get(variable), 
                    data = glioblastoma_data_complete)
  
  # Generate the plot
  ggsurv_plot <- ggsurvplot(
    km_fit,
    data = glioblastoma_data_complete,
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
    ggtitle(paste("Overall Survival stratified by", variable, "Cut-off optimal glioblastoma pat."))
  
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
  km_fit <- survfit(Surv(pfs_in_months, censor_pfs) ~ get(variable), data = glioblastoma_data_complete)
  
  # Generate the plot
  ggsurv_plot <- ggsurvplot(
    km_fit,
    data = glioblastoma_data_complete,
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
    ggtitle(paste("Progression-free Survival stratified by", variable, "Cut-off optimal glioblastoma pat."))
  
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


