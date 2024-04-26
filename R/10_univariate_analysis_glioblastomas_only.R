library(tidyverse)
library(survival)
library(survminer)
library(gtsummary)

# Load glioblastoma data clean_w_binary_2: including the different binary variables
glioblastoma_data_complete <- readRDS("input/glioblastoma_data_complete.rds")
str(glioblastoma_data_complete)

# Remove unused levels#########
glioblastoma_data_complete$resection
if ("Biopsy" %in% levels(glioblastoma_data_complete$resection)) {
  glioblastoma_data_complete$resection <- droplevels(glioblastoma_data_complete$resection, exclude = "Biopsy")
}
levels(glioblastoma_data_complete$resection)


levels(glioblastoma_data_complete$therapy)
if ("Radiotherapy followed by PC" %in% levels(glioblastoma_data_complete$therapy)) {
  glioblastoma_data_complete$therapy <- droplevels(glioblastoma_data_complete$therapy, 
                                                   exclude = "Radiotherapy followed by PC")
}
levels(glioblastoma_data_complete$therapy)

str(glioblastoma_data_complete)

# Univariate analysis of Overall Survival - by optimal cut-off##############
theme_gtsummary_compact()
os_table <- glioblastoma_data_complete %>%
  select(sex, age_at_diagnosis_binary, mgmt_status, localization_pre_op_binary, 
         resection, dexa_intake, therapy,
         os_in_months, censor_os, CXCL11_binary_optimal, CD83_binary_optimal, 
         VEGFA_binary_optimal,CXCL9_binary_optimal, CD5_binary_optimal, 
         CD40_binary_optimal, CD244_binary_optimal, IL6_binary_optimal,
         PDL1_binary_optimal, IL8_binary_optimal, LAP_TGF_beta_1_binary_optimal) %>%
  tbl_uvregression(
    method = coxph,
    y = Surv(os_in_months, censor_os),
    exponentiate = TRUE,
    pvalue_fun = ~style_pvalue(.x, digits = 2)
  ) %>%
  modify_caption("**Table 1: Univariate Analysis OS - Optimal cut-off method**") %>%
  add_global_p() %>% 
  add_q()%>%
  add_nevent() %>% 
  bold_p() %>% 
  bold_p(t = 0.10, q = TRUE) %>% 
  bold_labels()
print(os_table)

# Convert to gt
formatted_table_os_univariate_gt <- as_gt(os_table)

# Add additional customization with gt
formatted_table_os_univariate_gt <- formatted_table_os_univariate_gt %>%
  tab_header(
    title = "Overall survival by Optimal cut-off method",
    subtitle = "Univariate Cox regression"
  )

#Print formatted table
print(formatted_table_os_univariate_gt)





# Univariate analysis of Progression-free Survival - by optimal cut-off##############
theme_gtsummary_compact()
pfs_table <- glioblastoma_data_complete %>%
  select(sex, age_at_diagnosis_binary, mgmt_status, localization_pre_op_binary, 
         resection, dexa_intake, therapy,
         pfs_in_months, censor_pfs, CXCL11_binary_optimal, CD83_binary_optimal, 
         VEGFA_binary_optimal,CXCL9_binary_optimal, CD5_binary_optimal, 
         CD40_binary_optimal, CD244_binary_optimal, IL6_binary_optimal,
         PDL1_binary_optimal, IL8_binary_optimal, LAP_TGF_beta_1_binary_optimal) %>%
  tbl_uvregression(
    method = coxph,
    y = Surv(pfs_in_months, censor_pfs),
    exponentiate = TRUE,
    pvalue_fun = ~style_pvalue(.x, digits = 2)
  ) %>%
  modify_caption("**Table 1: Univariate Analysis PFS - Optimal cut-off method**") %>%
  add_global_p() %>% 
  add_q()%>%
  add_nevent() %>% 
  bold_p() %>% 
  bold_p(t = 0.10, q = TRUE) %>% 
  bold_labels()
print(pfs_table)

# Convert to gt
formatted_table_pfs_univariate_gt <- as_gt(pfs_table)

# Add additional customization with gt
formatted_table_pfs_univariate_gt <- formatted_table_pfs_univariate_gt %>%
  tab_header(
    title = "Progression-free survival by Optimal cut-off method",
    subtitle = "Univariate Cox regression"
  )

#Print formatted table
print(formatted_table_pfs_univariate_gt)





# Print merged table######################
theme_gtsummary_compact()
merged_table_univariate_optimal_cutoff <- tbl_merge(
  list(pfs_table, os_table),
  tab_spanner = c("**Progression-free survival**", "**Overall survival**"))

merged_table_univariate_optimal_cutoff <- merged_table_univariate_optimal_cutoff %>%
  modify_caption("")

merged_table_univariate_optimal_cutoff_gt <- as_gt(merged_table_univariate_optimal_cutoff)
print(merged_table_univariate_optimal_cutoff_gt)

# Add additional customization with gt
formatted_merged_table_univariate_optimal_cutoff_gt <- merged_table_univariate_optimal_cutoff_gt %>%
  tab_header(
    title = "Univariate analysis: Optimal cut-off method, Glioblastoma only",
    subtitle = "Univariate Cox regression"
  )
print(formatted_merged_table_univariate_optimal_cutoff_gt)







# Univariate analysis of Overall Survival - by median cut-off################
theme_gtsummary_compact()
os_table_2 <- glioblastoma_data_complete %>%
  select(sex, age_at_diagnosis_binary, mgmt_status, localization_pre_op_binary, 
         resection, dexa_intake, therapy,
         os_in_months, censor_os, CXCL11_binary_2, CD83_binary_2, 
         VEGFA_binary_2,CXCL9_binary_2, CD5_binary_2, 
         CD40_binary_2, CD244_binary_2, IL6_binary_2,
         PDL1_binary_2, IL8_binary_2, LAP_TGF_beta_1_binary_2) %>%
  tbl_uvregression(
    method = coxph,
    y = Surv(os_in_months, censor_os),
    exponentiate = TRUE,
    pvalue_fun = ~style_pvalue(.x, digits = 2)
  ) %>%
  modify_caption("**Table 1: Univariate Analysis OS - Median cut-off method**") %>%
  add_global_p() %>% 
  add_q()%>%
  add_nevent() %>% 
  bold_p() %>% 
  bold_p(t = 0.10, q = TRUE) %>% 
  bold_labels()
print(os_table_2)

# Convert to gt
formatted_table_os_univariate_2_gt <- as_gt(os_table_2)

# Add additional customization with gt
formatted_table_os_univariate_2_gt <- formatted_table_os_univariate_2_gt %>%
  tab_header(
    title = "Overall survival by Median cut-off method",
    subtitle = "Univariate Cox regression"
  )

#Print formatted table
print(formatted_table_os_univariate_2_gt)



# Univariate analysis of Progression-free Survival - by median cut-off################
theme_gtsummary_compact()
pfs_table_2 <- glioblastoma_data_complete %>%
  select(sex, age_at_diagnosis_binary, mgmt_status, localization_pre_op_binary, 
         resection, dexa_intake, therapy,
         pfs_in_months, censor_pfs, CXCL11_binary_2, CD83_binary_2, 
         VEGFA_binary_2,CXCL9_binary_2, CD5_binary_2, 
         CD40_binary_2, CD244_binary_2, IL6_binary_2,
         PDL1_binary_2, IL8_binary_2, LAP_TGF_beta_1_binary_2) %>%
  tbl_uvregression(
    method = coxph,
    y = Surv(pfs_in_months, censor_pfs),
    exponentiate = TRUE,
    pvalue_fun = ~style_pvalue(.x, digits = 2)
  ) %>%
  modify_caption("**Table 1: Univariate Analysis PFS - Median cut-off method**") %>%
  add_global_p() %>% 
  add_q()%>%
  add_nevent() %>% 
  bold_p() %>% 
  bold_p(t = 0.10, q = TRUE) %>% 
  bold_labels()
print(pfs_table_2)

# Convert to gt
formatted_table_pfs_univariate_2_gt <- as_gt(pfs_table_2)

# Add additional customization with gt
formatted_table_pfs_univariate_2_gt <- formatted_table_pfs_univariate_2_gt %>%
  tab_header(
    title = "Progression-free survival by Median cut-off method",
    subtitle = "Univariate Cox regression"
  )

#Print formatted table
print(formatted_table_pfs_univariate_2_gt)

# Print merged table######################
theme_gtsummary_compact()
merged_table_univariate_median_cutoff <- tbl_merge(
  list(pfs_table_2, os_table_2),
  tab_spanner = c("**Progression-free survival**", "**Overall survival**"))

merged_table_univariate_median_cutoff <- merged_table_univariate_median_cutoff %>%
  modify_caption("")

merged_table_univariate_median_cutoff_gt <- as_gt(merged_table_univariate_median_cutoff)
print(merged_table_univariate_median_cutoff_gt)

# Add additional customization with gt
formatted_merged_table_univariate_median_cutoff_gt <- merged_table_univariate_median_cutoff_gt %>%
  tab_header(
    title = "Univariate analysis: Median cut-off, Glioblastoma only",
    subtitle = "Univariate Cox regression"
  )
print(formatted_merged_table_univariate_median_cutoff_gt)
