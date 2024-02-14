#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


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