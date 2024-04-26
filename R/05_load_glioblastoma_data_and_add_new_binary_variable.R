library(tidyverse)

# Import clean_data_w_binary from rds file stored in the /input folder
glioblastoma_data_clean <- readRDS(file = "input/glioblastoma_data_clean.rds")
str(glioblastoma_data_clean)

# Define proteins of interest
variable_names <- c("CXCL11", "CD83", "CD40", 
                    "CD5", "LAP_TGF_beta_1", "VEGFA",
                    "PDL1", "CD244", "IL6", "IL8", 
                    "CXCL9")

source("R/functions.R")

# Generate binary variables "binary" for proteins of interest using glioblastoma only median as cut-off 
## Call the function and assign the returned dataframe to a new variable
glioblastoma_data_clean_w_binary <- generate_binary_var_median_cutoff_glioblastoma(glioblastoma_data_clean, variable_names)
str(glioblastoma_data_clean_w_binary)


variable_names_factors <- c("CXCL11_binary", "CD83_binary", "CD40_binary", 
                            "CD5_binary", "LAP_TGF_beta_1_binary", "VEGFA_binary",
                            "PDL1_binary", "CD244_binary", "IL6_binary", "IL8_binary", 
                            "CXCL9_binary")
source("R/functions.R")

glioblastoma_data_clean_w_binary_2 <- convert_to_factor(glioblastoma_data_clean_w_binary, variable_names_factors)
str(glioblastoma_data_clean_w_binary_2)


saveRDS(glioblastoma_data_clean_w_binary_2, "input/glioblastoma_data_clean_w_binary_2.rds")
