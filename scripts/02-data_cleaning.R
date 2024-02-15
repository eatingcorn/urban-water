#### Preamble ####
# Purpose: Cleans data from
# "Urban Water Disinfection and Mortality Decline in Lower-Income Countries" (Bhalotra et al. 2021)
# Author: Ricky Fung
# Date: 15 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Run script "01-download_data.R"


#### Workspace setup ####
library(tidyverse)

#### Clean data ####
beneficiaries_data <- read_csv("data/raw_data/beneficiaries_raw.csv")
mortality_data <- read_csv("data/raw_data/mortality_raw.csv")
pipe_data <- read_csv("data/raw_data/pipe_data_raw.csv")


beneficiaries_cleaned <- 
  beneficiaries_data %>% mutate(year = year + (month - 1) / 12) %>% 
  rename(beneficiaries = benef) %>% select(year, beneficiaries)


mortality_cleaned <- 
  mortality_data %>% select(ln_deaths2, year)


#### Save data ####
write_csv(beneficiaries_cleaned, "data/analysis_data/beneficiaries_cleaned.csv")
write_csv(mortality_cleaned, "data/analysis_data/mortality_cleaned.csv")
write_csv(pipe_data, "data/analysis_data/pipe_cleaned.csv")
