library(tidyverse)
library(survminer)
library(survival)

# Import clean_data from rds file stored in the /input folder
clean_data <- readRDS(file = "input/clean_data.rds")
str(clean_data)

# Use function stored in the /R folder under functions.R
source("R/functions.R")

# Define proteins of interest
variable_names <- c("CXCL11", "CD83", "CD40", 
                    "CD5", "LAP_TGF_beta_1", "VEGFA",
                    "PDL1", "CD244", "IL6", "IL8", 
                    "CXCL9")

# Generate binary variables "binary_2" for proteins of interest using median as cut-off
## Call the function and assign the returned dataframe to a new variable
clean_data_w_binary <- generate_binary_var_median_cutoff(clean_data, variable_names)


# Save updated rds file
saveRDS(clean_data_w_binary, file = "input/clean_data_w_binary.rds")
str(clean_data_w_binary)
