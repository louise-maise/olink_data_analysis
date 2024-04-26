library(tidyverse)

# Load glioblastoma data including the 2 different binary variables
glioblastoma_data_extended_binary <- readRDS("input/glioblastoma_data_extended_binary.rds")


# Convert median cutoff binary variable to factor
variable_names_factors_median <- c("CXCL11_binary_median", "CD83_binary_median", "IL8_binary_median", "TNFRSF9_binary_median", "TIE2_binary_median", "MCP_3_binary_median", "CD40_L_binary_median", "IL_1_alpha_binary_median", 
                            "CD244_binary_median", "EGF_binary_median", "ANG_1_binary_median", "IL7_binary_median", "PGF_binary_median", "IL6_binary_median", "ADGRG1_binary_median", 
                            "MCP_1_binary_median", "MCP_4_binary_median", "TRAIL_binary_median", "FGF2_binary_median", "CXCL9_binary_median", "CD8A_binary_median",
                            "CAIX_binary_median", "ADA_binary_median", "CD4_binary_median", "NOS3_binary_median", "Gal_9_binary_median",
                            "VEGFR2_binary_median", "CD40_binary_median", "IL18_binary_median", "GZMH_binary_median", "VEGFC_binary_median", "LAP_TGF_beta_1_binary_median",
                            "CXCL1_binary_median", "TNFSF14_binary_median", "IL33_binary_median", "TWEAK_binary_median", "PDGF subunit B_binary_median", "PDCD1_binary_median",
                            "FASLG_binary_median", "CD28_binary_median", "CCL19_binary_median", "MCP_2_binary_median", "CCL4_binary_median", "Gal_1_binary_median",
                            "PDL1_binary_median", "CD27_binary_median", "CXCL5_binary_median", "HGF_binary_median", "GZMA_binary_median", "HO_1_binary_median",
                            "CX3CL1_binary_median", "CXCL10_binary_median", "CD70_binary_median", "TNFRSF12A_binary_median", "CCL23_binary_median",
                            "CD5_binary_median", "CCL3_binary_median", "MMP7_binary_median", "ARG1_binary_median", "DCN_binary_median", "TNFRSF21_binary_median",
                            "TNFRSF4_binary_median", "MIC_A_B_binary_median", "CCL17_binary_median", "ANGPT2_binary_median", "PTN_binary_median", "CXCL12_binary_median",
                            "LAMP3_binary_median", "CASP_8_binary_median", "ICOSLG_binary_median", "MMP12_binary_median", "CXCL13_binary_median",
                            "PD_L2_binary_median", "VEGFA_binary_median", "IL4_binary_median", "IL12RB1_binary_median", "CCL20_binary_median",
                            "KLRD1_binary_median", "GZMB_binary_median", "IL12_binary_median", "CSF_1_binary_median")

source("R/functions.R")

glioblastoma_data_clean_extended <- convert_to_factor_median(glioblastoma_data_extended_binary, variable_names_factors_median)
str(glioblastoma_data_clean_extended$CXCL11_binary_median)


# Convert optimal cutoff binary variable to factor
variable_names_factors_optimal <- c("CXCL11_binary_optimal", "CD83_binary_optimal", "IL8_binary_optimal", "TNFRSF9_binary_optimal", "TIE2_binary_optimal", "MCP_3_binary_optimal", "CD40_L_binary_optimal", "IL_1_alpha_binary_optimal", 
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

glioblastoma_data_clean_extended <- convert_to_factor_optimal(glioblastoma_data_extended_binary, variable_names_factors_optimal)
str(glioblastoma_data_clean_extended$CXCL11_binary_optimal)

saveRDS(glioblastoma_data_clean_extended, "input/glioblastoma_data_clean_extended.rds")
