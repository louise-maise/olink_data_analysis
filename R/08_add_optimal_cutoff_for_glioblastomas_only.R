library(tidyverse)
library(survival)
library(survminer)

# Load glioblastoma data clean_w_binary_2: including the 2 different binary variables
glioblastoma_data_clean_w_binary_2 <- readRDS("input/glioblastoma_data_clean_w_binary_2.rds")
str(glioblastoma_data_clean_w_binary_2)

# List of variables
variables <- c("CXCL11", "CD83", "CD40", 
               "CD5", "LAP_TGF_beta_1", "VEGFA",
               "PDL1", "CD244", "IL6", "IL8", 
               "CXCL9")


# Iterate over each variable
for (variable in variables) {
  
  # Calculate optimal cutpoint for the current variable
  optimal_cutpoint <- surv_cutpoint(
    data = glioblastoma_data_clean_w_binary_2,
    variables = variable,
    time = "os_in_months",
    event = "censor_os"
  )
  
  # Extract the optimal cutoff value
  optimal_cutoff_value <- optimal_cutpoint$cutpoint
  
  # Create a binary variable indicating whether the current variable is above the optimal cutoff
  glioblastoma_data_clean_w_binary_2[[paste0(variable, "_binary_optimal")]] <- glioblastoma_data_clean_w_binary_2[[variable]] > optimal_cutoff_value$cutpoint
}

datatable(glioblastoma_data_clean_w_binary_2)
str(glioblastoma_data_clean_w_binary_2)

saveRDS(glioblastoma_data_clean_w_binary_2, "input/glioblastoma_data_complete.rds")
