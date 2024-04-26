library(tidyverse)
library(dplyr)

generate_binary_var_median_cutoff <- function(data, variable_names) {
  for (var_name in variable_names) {
    median_value <- median(data[[var_name]], na.rm = TRUE)
    binary_2_var_name <- paste0(var_name, "_binary_2")  # Adjusted suffix for binary variables
    data <- data %>%
      mutate(!!binary_2_var_name := ifelse(.data[[var_name]] >= median_value, "High", "Low"))
  }
  return(data)
}

generate_binary_var_median_cutoff_glioblastoma <- function(data, variable_names) {
  for (var_name in variable_names) {
    median_value <- median(data[[var_name]], na.rm = TRUE)
    binary_var_name <- paste0(var_name, "_binary_median")  # Adjusted suffix for binary variables
    data <- data %>%
      mutate(!!binary_var_name := ifelse(.data[[var_name]] >= median_value, "High", "Low"))
  }
  return(data)
}

convert_to_factor <- function(data, variable_names) {
  for (variable in variable_names) {
    data[[variable]] <- as.factor(data[[variable]])
  }
  return(data)
}

convert_to_factor_median <- function(data, variable_names) {
  for (variable in variable_names) {
      data[[variable]] <- as.factor(data[[variable]])
    }
  return(data)
}

convert_to_factor_optimal <- function(data, variable_names) {
  for (variable in variable_names) {
    data[[variable]] <- as.factor(ifelse(data[[variable]], "High", "Low"))
  }
  return(data)
}