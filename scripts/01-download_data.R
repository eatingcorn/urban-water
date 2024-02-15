#### Preamble ####
# Purpose: Saves data from
# "Urban Water Disinfection and Mortality Decline in Lower-Income Countries" (Bhalotra et al. 2021)
# Author: Ricky Fung
# Date: 15 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Install haven package.


#### Workspace setup ####
library(tidyverse)
library(haven)

#### Download data ####

beneficiaries_data <- read_dta("data/raw_data/PAL_pop_loc_covg.dta")
mortality_data <- read_dta("data/raw_data/analysisfile_7997.dta")
pipe_data <- read_dta("data/raw_data/analysisfile_8595.dta")


#### Save data ####

write_csv(beneficiaries_data, "data/raw_data/beneficiaries_raw.csv") 
write_csv(mortality_data, "data/raw_data/mortality_raw.csv") 
write_csv(pipe_data, "data/raw_data/pipe_data_raw.csv") 