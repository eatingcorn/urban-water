#### Preamble ####
# Purpose: Simulates data from
# "Urban Water Disinfection and Mortality Decline in Lower-Income Countries" (Bhalotra et al. 2021)
# Author: Ricky Fung
# Date: 15 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Install tidyverse.


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####

set.seed(302)

# Simulation for beneficiaries
simulate_beneficiaries <- tibble(
  year = seq(1991.25, 1994.917),
  beneficiaries = sample(35:70, 4, replace = TRUE))

# Simulation for mortality rates
simulate_mortality <- tibble(
  year_reg = seq(1979, 1997),
  ln_deaths2 = sample(5:11, 19, replace = TRUE))


# Test min
simulate_beneficiaries$year %>% min() == 1991.25

# Test length
simulate_beneficiaries$beneficiaries %>% length() == 4

# Test Max
simulate_mortality$year_reg %>% max() == 1997

# Test min
simulate_mortality$year_reg %>% min() == 1979

# Test length
simulate_mortality$ln_deaths2 %>% length == 19

