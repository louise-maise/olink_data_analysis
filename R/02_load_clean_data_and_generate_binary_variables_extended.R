library(tidyverse)
library(survminer)
library(survival)

# Create a dataframe including only glioblastoma patients

# Import clean_data from rds file stored in the /input folder
clean_data_extended <- readRDS(file = "input/clean_data_extended.rds")
str(clean_data_extended)

glioblastoma_data_extended <- clean_data_extended %>%
  filter(hgg_comparison == "glioblastoma")
datatable(glioblastoma_data_extended)

saveRDS(glioblastoma_data_extended, file = "input/glioblastoma_data_extended.rds")


# Use function stored in the /R folder under functions.R
source("R/functions.R")

# Define proteins of interest
variables <- c("CXCL11", "CD83", "IL8", "TNFRSF9", "TIE2", "MCP_3", "CD40_L", "IL_1_alpha", 
                    "CD244", "EGF", "ANG_1", "IL7", "PGF", "IL6", "ADGRG1", 
                    "MCP_1", "MCP_4", "TRAIL", "FGF2", "CXCL9", "CD8A",
                    "CAIX", "ADA", "CD4", "NOS3", "Gal_9",
                    "VEGFR2", "CD40", "IL18", "GZMH", "VEGFC", "LAP_TGF_beta_1",
                    "CXCL1", "TNFSF14", "IL33", "TWEAK", "PDGF subunit B", "PDCD1",
                    "FASLG", "CD28", "CCL19", "MCP_2", "CCL4", "Gal_1",
                    "PDL1", "CD27", "CXCL5", "HGF", "GZMA", "HO_1",
                    "CX3CL1", "CXCL10", "CD70", "TNFRSF12A", "CCL23",
                    "CD5", "CCL3", "MMP7", "ARG1", "DCN", "TNFRSF21",
                    "TNFRSF4", "MIC_A_B", "CCL17", "ANGPT2", "PTN", "CXCL12",
                    "LAMP3", "CASP_8", "ICOSLG", "MMP12", "CXCL13",
                    "PD_L2", "VEGFA", "IL4", "IL12RB1", "CCL20",
                    "KLRD1", "GZMB", "IL12", "CSF_1")


# Generate variables "binary_optimal" for proteins of interest using optimal cut-off
# Iterate over each variable
for (variable in variables) {
  
  # Calculate optimal cutpoint for the current variable
  optimal_cutpoint <- surv_cutpoint(
    data = glioblastoma_data_extended,
    variables = variable,
    time = "os_in_months",
    event = "censor_os"
  )
  
  # Extract the optimal cutoff value
  optimal_cutoff_value <- optimal_cutpoint$cutpoint
  
  # Create a binary variable indicating whether the current variable is above the optimal cutoff
  glioblastoma_data_extended[[paste0(variable, "_binary_optimal")]] <- glioblastoma_data_extended[[variable]] > optimal_cutoff_value$cutpoint
}

datatable(glioblastoma_data_extended)


# Generate binary variables "binary_median" for proteins of interest using median cut-off
## Call the function and assign the returned dataframe to a new variable
glioblastoma_data_extended_binary <- generate_binary_var_median_cutoff_glioblastoma(
  glioblastoma_data_extended, variables)
datatable(glioblastoma_data_extended_binary)


# Save updated rds file
saveRDS(glioblastoma_data_extended_binary, file = "input/glioblastoma_data_extended_binary.rds")

