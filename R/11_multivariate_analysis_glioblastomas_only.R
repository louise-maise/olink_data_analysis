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



# Create a survival object for Cox model building
os_survival_data_cox <- Surv(time = glioblastoma_data_complete$os_in_months, 
                             event = glioblastoma_data_complete$censor_os)
pfs_survival_data_cox <- Surv(time = glioblastoma_data_complete$pfs_in_months, 
                              event = glioblastoma_data_complete$censor_pfs)

# Considering factors significant in Univariate Analysis (optimal cut-off method):

# Define the list of predictors to add one at a time
predictors <- c("VEGFA_binary_optimal", "CXCL9_binary_optimal", 
                "CD40_binary_optimal", "IL6_binary_optimal", 
                "LAP_TGF_beta_1_binary_optimal")

# Initialize a list to store the models and tables
cox_models <- list()
cox_tables <- list()

# Fit Cox proportional hazards models and generate tables
for (predictor in predictors) {
  # Formulate the formula for the Cox model
  formula <- paste("os_survival_data_cox ~ age_at_diagnosis_binary + mgmt_status +",
                   "localization_pre_op_binary + resection +", predictor)
  
  # Fit Cox model
  cox_model <- coxph(as.formula(formula), data = glioblastoma_data_complete)
  
  # Generate summary table
  cox_table <- tbl_regression(
    cox_model,
    exponentiate = TRUE,  # Display hazard ratios instead of coefficients
    pvalue_fun = function(p) style_pvalue(p, digits = 3)  # Format p-values
  ) %>%
    bold_labels() %>%
    modify_caption(paste("**Table for", predictor, "**")) %>%
    modify_header(
      label = "**Parameter**",
      estimate = "**HR**",
      ci = "**95% CI**",
      p.value = "**p-value**",
    ) %>%
    bold_p(t= 0.05, q=FALSE)
  
  # Store model and table in the respective lists
  cox_models[[predictor]] <- cox_model
  cox_tables[[predictor]] <- cox_table
}

# Print all generated tables
for (predictor in predictors) {
  print(cox_tables[[predictor]])
}


## Build the Cox proportional hazards model for OS###############################
cox_model_os <- coxph(os_survival_data_cox ~ age_at_diagnosis_binary + mgmt_status 
                      + localization_pre_op_binary + resection + VEGFA_binary_optimal
                      + CXCL9_binary_optimal + CD40_binary_optimal + IL6_binary_optimal
                      + LAP_TGF_beta_1_binary_optimal,
                      data = glioblastoma_data_complete)
theme_gtsummary_compact()
cox_model_table_os <- tbl_regression(
  cox_model_os,
  exponentiate = TRUE,  # Display hazard ratios instead of coefficients
  pvalue_fun = function(p) style_pvalue(p, digits = 3)  # Format p-values
) %>%
  bold_labels() %>%
  modify_caption("**Table 4: Multivariate Analysis**") %>%
  #modify_spanning_header(everything() ~ "Overall Survival") %>%
  modify_header(
    label = "**Parameter**",
    estimate = "**HR**",
    ci = "**95% CI**",
    p.value = "**p-value**",
  ) %>%
  bold_p(t= 0.05, q=FALSE)
print(cox_model_table_os)

# Convert to gt
formatted_table_os_gt <- as_gt(cox_model_table_os)

# Add additional customization with gt
formatted_table_os_gt <- formatted_table_os_gt %>%
  tab_header(
    title = "Overall survival",
    subtitle = "Multivariate Cox regression"
  )

# Print the formatted tables
theme_gtsummary_compact()
print(formatted_table_os_gt)













## Build the Cox proportionate hazards model for PFS#############################
cox_model_pfs <- coxph(pfs_survival_data_cox ~ age_at_diagnosis_binary + mgmt_status 
                       + resection + localization_pre_op_binary 
                       + LAP_TGF_beta_1_binary_optimal,
                       data = glioblastoma_data_complete)
theme_gtsummary_compact()
cox_model_table_pfs <- tbl_regression(
  cox_model_pfs,
  exponentiate = TRUE,  # Display hazard ratios instead of coefficients
  pvalue_fun = function(p) style_pvalue(p, digits = 3)  # Format p-values
) %>%
  bold_labels() %>%
  modify_caption("**Table 4: Multivariate Analysis**") %>%
  modify_header(
    label = "**Parameter**",
    estimate = "**HR**",
    ci = "**95% CI**",
    p.value = "**p-value**",
  ) %>%
  bold_p(t= 0.05, q=FALSE)
print(cox_model_table_pfs)

# Convert to gt
formatted_table_pfs_gt <- as_gt(cox_model_table_pfs)

# Add additional customization with gt
formatted_table_pfs_gt <- formatted_table_pfs_gt %>%
  tab_header(
    title = "Progression-free survival",
    subtitle = "Multivariate Cox regression"
  )

# Print the formatted tables
theme_gtsummary_compact()
print(formatted_table_pfs_gt)
