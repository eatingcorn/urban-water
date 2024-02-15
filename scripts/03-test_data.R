#### Preamble ####
# Purpose: Tests cleaned data set to ensure accuracy.
# Author: Ricky Fung
# Date: 15 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Run scripts "01-download_data.R" and "02-data_cleaning.R".


#### Workspace setup ####
library(tidyverse)

beneficiaries_data <- read_csv("data/analysis_data/beneficiaries_cleaned.csv")
mortality_data <- read_csv("data/analysis_data/mortality_cleaned.csv")

#### Test data ####

# Test min
beneficiaries_data$year %>% min() == 1991.25

# Test length
beneficiaries_data$beneficiaries %>% length() == 4

# Test max
mortality_data$year %>% max() == 1997

# Test min
mortality_data$year %>% min() == 1979

# Test length
mortality_data$ln_deaths2 %>% length == 19