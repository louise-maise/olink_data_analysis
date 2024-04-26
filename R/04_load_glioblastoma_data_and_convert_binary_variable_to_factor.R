library(tidyverse)

# Import clean_data_w_binary from rds file stored in the /input folder
glioblastoma_data <- readRDS(file = "input/glioblastoma_data.rds")
str(glioblastoma_data)

variable_names_factors <- c("CXCL11_binary_2", "CD83_binary_2", "CD40_binary_2", 
                            "CD5_binary_2", "LAP_TGF_beta_1_binary_2", "VEGFA_binary_2",
                            "PDL1_binary_2", "CD244_binary_2", "IL6_binary_2", "IL8_binary_2", 
                            "CXCL9_binary_2")
source("R/functions.R")

glioblastoma_data_clean <- convert_to_factor(glioblastoma_data, variable_names_factors)

str(glioblastoma_data_clean)

saveRDS(glioblastoma_data_clean, "input/glioblastoma_data_clean.rds")
