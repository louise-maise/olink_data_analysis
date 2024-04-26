library(tidyverse)

# Load gt packages
library(gtsummary)
library(gt)

# Create Table showing patient characteristics for all patients
clean_data_w_binary <- readRDS("input/clean_data_w_binary.rds")
str(clean_data_w_binary)


clean_data_w_binary %>%
  select(hgg_comparison, age_at_diagnosis_yrs, age_at_diagnosis_binary, sex, os_in_months, pfs_in_months, dexa_intake, mgmt_status,
         localization_pre_op_binary, karnofsky_pre_op_binary, resection, therapy) %>%
  tbl_summary(
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_continuous2() ~ "{median} ({p25}, {p75})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    type = list(
      dexa_intake ~ "categorical", 
      os_in_months ~ "continuous2", 
      pfs_in_months ~ "continuous2",
      age_at_diagnosis_yrs ~ "continuous",
      age_at_diagnosis_binary ~ "categorical",
      hgg_comparison ~ "categorical",
      sex ~ "categorical", 
      localization_pre_op_binary ~ "categorical", 
      resection ~ "categorical",
      mgmt_status ~ "categorical", 
      therapy ~ "categorical", 
      karnofsky_pre_op_binary ~ "categorical"),
    digits = all_continuous() ~ 2,
    label = list(
      os_in_months = "Median Overall Survival (months)",
      pfs_in_months = "Median Progression-free Survival (months)",
      age_at_diagnosis_yrs = "Mean Age at diagnosis in yrs",
      age_at_diagnosis_binary = "Age group at diagnosis",
      hgg_comparison = "Diagnosis according to WHO CNS 5",
      sex = "Sex",
      mgmt_status = "MGMT promotor methylation status",
      dexa_intake = "Dexamethasone intake",
      localization_pre_op_binary = "Tumor localization pre-op.",
      karnofsky_pre_op_binary = "KPS pre-op.",
      therapy = "First line of therapy",
      resection = "Grade of resection"
    )
  ) %>%
  bold_labels() %>%
  modify_caption("**Table 1. Patient Characteristics**")



# Create Table showing patient characteristics for glioblastoma patients only

glioblastoma_data_clean_w_binary_2 <- readRDS("input/glioblastoma_data_clean_w_binary_2.rds")
str(glioblastoma_data_clean_w_binary_2)

glioblastoma_data_clean_w_binary_2 %>%
  select(age_at_diagnosis_yrs, age_at_diagnosis_binary, sex, os_in_months, pfs_in_months, dexa_intake, mgmt_status,
         localization_pre_op_binary, karnofsky_pre_op_binary, resection, therapy) %>%
  tbl_summary(
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_continuous2() ~ "{median} ({p25}, {p75})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    type = list(
      dexa_intake ~ "categorical", 
      os_in_months ~ "continuous2", 
      pfs_in_months ~ "continuous2",
      age_at_diagnosis_yrs ~ "continuous",
      age_at_diagnosis_binary ~ "categorical",
      sex ~ "categorical", 
      localization_pre_op_binary ~ "categorical", 
      resection ~ "categorical",
      mgmt_status ~ "categorical", 
      therapy ~ "categorical", 
      karnofsky_pre_op_binary ~ "categorical"),
    digits = all_continuous() ~ 2,
    label = list(
      os_in_months = "Median Overall Survival (months)",
      pfs_in_months = "Median Progression-free Survival (months)",
      age_at_diagnosis_yrs = "Mean Age at diagnosis in yrs",
      age_at_diagnosis_binary = "Age group at diagnosis",
      sex = "Sex",
      mgmt_status = "MGMT promotor methylation status",
      dexa_intake = "Dexamethasone intake",
      localization_pre_op_binary = "Tumor localization pre-op.",
      karnofsky_pre_op_binary = "KPS pre-op.",
      therapy = "First line of therapy",
      resection = "Grade of resection"
    )
  ) %>%
  bold_labels() %>%
  modify_caption("**Table 1. Patient Characteristics - Glioblastoma patients only**")
