# Load libraries
library(tidyverse)
library(survival)
library(survminer)

# Read the clean dataset
clean_data <- readRDS(file = "input/clean_data.rds")
glioblastoma_data_w_binary_2 <- readRDS(file = "input/clean_data.rds")

# Generate binary variables "binary_optimal" for proteins of interest using optimal cut-off 
variable_names <- c("CXCL11", "CD83", "CD40", 
                    "CD5", "LAP_TGF_beta_1", "VEGFA",
                    "PDL1", "CD244", "IL6", "IL8", 
                    "CXCL9")

# Create a copy of the original dataset to preserve the original data
data_with_binary_optimal <- clean_data

## Iterate over each variable
for (variable in variable_names) {
  
  # Calculate optimal cutpoint for the current variable using only glioblastoma data
  optimal_cutpoint <- surv_cutpoint(
    data = glioblastoma_data_w_binary_2,
    variables = variable,
    time = "os_in_months",
    event = "censor_os"
  )
  
  # Extract the optimal cutoff value
  optimal_cutoff_value <- optimal_cutpoint$cutpoint
  
  ## Create a binary variable indicating whether the current variable is above the optimal cutoff
  data_with_binary_optimal[[paste0(variable, "_binary_optimal")]] <- data_with_binary_optimal[[variable]] > optimal_cutoff_value$cutpoint
}


## Convert numerical binary values to factors "High" and "Low", calling function "convert_to_factor"
variable_names_factors_optimal <- paste0(variable_names, "_binary_optimal")
source("R/functions.R")
data_with_binary_optimal <- convert_to_factor_optimal(data_with_binary_optimal, variable_names_factors_optimal)

datatable(data_with_binary_optimal)
