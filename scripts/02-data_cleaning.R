#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

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

pipe_cleaned <- 
  pipe_data %>% 
  filter(rur < 1 & year_reg == 1990 & treated2 == 2) %>% 
  select(pipe_shr6090, ln_pipe)



#### Save data ####
write_csv(beneficiaries_cleaned, "data/raw_data/beneficiaries_cleaned.csv")
write_csv(mortality_cleaned, "data/raw_data/mortality_cleaned.csv")
write_csv(pipe_cleaned, "data/raw_data/pipe_cleaned.csv")
