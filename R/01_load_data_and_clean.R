library(tidyverse)
library(readxl)
library(dplyr)

mydata <- read_excel("C:/Users/lullu/Desktop/lab/olink_data_analysis/input/Olink_basic_data_06_04_2024.xlsx", 
                     sheet = "Data", na = "NA")
str(mydata)
mydata$sex <- as.factor(mydata$sex)
mydata$age_at_diagnosis_binary <- as.factor(mydata$age_at_diagnosis_binary)
mydata$dexa_intake <- as.factor(mydata$dexa_intake)
mydata$localization_pre_op_binary <- as.factor(mydata$localization_pre_op_binary)
mydata$resection <- as.factor(mydata$resection)
mydata$histology_at_diagnosis <- as.factor(mydata$histology_at_diagnosis)
mydata$hgg_comparison <- as.factor(mydata$hgg_comparison)
mydata$mgmt_status <- as.factor(mydata$mgmt_status)
mydata$idh_status <- as.factor(mydata$idh_status)
mydata$therapy <- as.factor(mydata$therapy)
mydata$karnofsky_pre_op_binary <- as.factor(mydata$karnofsky_pre_op_binary)
mydata$karnofsky_pre_op <- as.factor(mydata$karnofsky_pre_op)
str(mydata)

# Get rid of unnecessary columns
clean_data <- mydata %>%
  select(-localization_pre_op, 
         -histology_at_diagnosis, 
         -histology_at_diagnosis_binary, 
         -CXCL11_RNA, 
         -CD83_blood, 
         -Survival_OS, 
         -Survival_PFS)
str(clean_data)

# Columns to keep
columns_to_keep <- c("CXCL11", "CD83", "CD40", "CD5", "LAP_TGF_beta_1", "VEGFA",
                     "PDL1", "CD244", "IL6", "IL8", "CXCL9")

# Get the index of "Survival_PFS" column
survival_pfs_index <- which(names(clean_data) == "censor_pfs")

clean_data <- clean_data [, c(1:survival_pfs_index, 
                                                 which(names(clean_data) %in% columns_to_keep))]

str(clean_data)

saveRDS(clean_data, file = "input/clean_data.rds")

library(DT)
datatable(clean_data, filter = "top")

