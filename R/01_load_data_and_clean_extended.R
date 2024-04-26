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
clean_data_extended <- mydata %>%
  select(-localization_pre_op, 
         -histology_at_diagnosis, 
         -histology_at_diagnosis_binary, 
         -CXCL11_RNA, 
         -CD83_blood, 
         -Survival_OS, 
         -Survival_PFS)
str(clean_data_extended)

saveRDS(clean_data_extended, file = "input/clean_data_extended.rds")

library(DT)
datatable(clean_data_extended, filter = "top")

