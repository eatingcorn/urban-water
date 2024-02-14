#### Preamble ####
# Purpose: Replicated graphs from... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(dplyr)
# [...UPDATE THIS...]

#### Load data ####
beneficiaries_data <- read_csv("data/raw_data/beneficiaries_cleaned.csv")
mortality_data <- read_csv("data/raw_data/mortality_cleaned.csv")
pipe_data <- read_csv("data/raw_data/pipe_cleaned.csv")


# Replication of 2

# Plotting
figure_2 <- beneficiaries_data %>%
  ggplot(aes(x = t, y = benef)) +
  geom_line() +
  theme_minimal() +
  labs(x = "Year", y = "Beneficiaries (Millions)") +
  scale_x_continuous(breaks = seq(1991, 1995, 1)) +
  scale_y_continuous(labels = scales::comma) +
  theme(axis.text = element_text(size = 8))


# Replication of Figure 3

# Filtering
regression_data <- mortality_data  %>%
  filter(year >= 1971 & year <= 1985)

# Fit regression model
regression_model <- lm(ln_deaths2 ~ year, data = regression_data)

# Create predictions
predictions <- data.frame(year = seq(min(mortality_data $year), max(mortality_data $year), by = 1))
predictions$temp <- predict(regression_model, newdata = predictions)

# Plot
figure_3 <- data %>%
  ggplot(aes(x = year)) +
  geom_point(aes(y = ln_deaths2), color = "black") +
  geom_line(data = predictions, aes(y = temp), color = "gray80") +
  geom_line(data = data, aes(y = ln_deaths2), color = "black") +
  theme_minimal() +
  scale_x_continuous(breaks = seq(1979, 1997, by = 2)) +
  xlab("Year") +
  ylab("Ln(Under 5 Diarrheal Mortality)") +
  geom_vline(xintercept = 1991, linetype = "dashed", color="darkgray") +
  theme(legend.position = "none")


# Replication of Figure 7

# Scatter plot with linear fit
figure_7 <- ggplot(pipe_data, aes(x = pipe_shr6090, y = ln_pipe)) +
  geom_point(shape = 15, color = "black") +
  geom_smooth(method = "lm", se = FALSE, color= "grey") +
  labs(x = "Piped Water Share 1960/1990", y = "Ln(Pipe Breaks/Km)") +
  theme(axis.text = element_text(size = 8), axis.title = element_text(size = 10)) +
  theme_minimal()
