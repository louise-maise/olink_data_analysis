library(tidyverse)

# Import clean_data_w_binary from rds file stored in the /input folder
clean_data_w_binary <- readRDS(file = "input/clean_data_w_binary.rds")
str(clean_data_w_binary)
str(clean_data_w_binary$CXCL11_binary_2)

levels(clean_data_w_binary$hgg_comparison)

glioblastoma_data <- clean_data_w_binary %>%
  filter(hgg_comparison == "glioblastoma")
str(glioblastoma_data)
str(glioblastoma_data$CXCL11_binary_2)

saveRDS(glioblastoma_data, file = "input/glioblastoma_data.rds")
