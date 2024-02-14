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
beneficiaries_data <- read_csv("data/analysis_data/beneficiaries_cleaned.csv")
mortality_data <- read_csv("data/analysis_data/mortality_cleaned.csv")
pipe_data <- read_csv("data/analysis_data/pipe_cleaned.csv")


# Replication of Figure 2

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
regression_data <- mortality_data %>%
  filter(year >= 1971 & year <= 1985)

# Fit regression model
regression_model <- lm(ln_deaths2 ~ year, data = regression_data)

# Create predictions
predictions <- data.frame(year = seq(min(mortality_data$year), max(mortality_data$year), by = 1))
predictions$temp <- predict(regression_model, newdata = predictions)

# Plot
figure_3 <- mortality_data %>%
  ggplot(aes(x = year)) +
  geom_point(aes(y = ln_deaths2), color = "black") +
  geom_line(data = predictions, aes(y = temp), color = "gray80") +
  geom_line(aes(y = ln_deaths2), color = "black") +
  theme_minimal() +
  scale_x_continuous(breaks = seq(1979, 1997, by = 2)) +
  xlab("Year") +
  ylab("Ln(Under 5 Diarrheal Mortality)") +
  geom_vline(xintercept = 1991, linetype = "dashed", color = "darkgray") +
  theme(legend.position = "none")


# Replication of Figure 4

# Collapse data by specified variables
plot_12 <- pipe_data %>%
  group_by(year_reg, small_city, treated2) %>%
  summarise(deaths_under5 = sum(deaths_under5),
            livebirths = sum(livebirths),
            .groups = "drop")

# Calculate under 5 mortality rate and natural log
plot_12 <- plot_12 %>%
  mutate(rate_under5 = (deaths_under5 / livebirths) * 1000,
         ln_rate_under5 = log(rate_under5))

# Define labels for treated2 and small_city variables
plot_12$treated2 <- factor(plot_12$treated2, labels = c("Non-Infectious", "Respiratory Infectious", "Diarrheal Infections"))
plot_12$small_city <- factor(plot_12$small_city, labels = c("Large Cities", "Small/medium-sized cities"))

# Plot the graph
plot_data1 <- plot_12 %>%
  filter(small_city == "Small/medium-sized cities") %>%
  ggplot(aes(x = year_reg, y = ln_rate_under5, color = treated2)) +
  geom_line() +
  geom_point() +  
  scale_x_continuous(breaks = seq(1985, 1995, by = 1)) +
  labs(x = "Year", y = "Under 5 Mortality (logged)") +
  scale_color_manual(values = c("gray70", "black", "gray45")) +
  geom_vline(xintercept = 1991, linetype = "dashed") +
  theme(axis.text.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 15)) +
  guides(color = guide_legend(override.aes = list(size = 2))) 


# Plot the graph
plot_data2 <- plot_12 %>% na.omit() %>% 
  filter(treated2 == "Diarrheal Infections") %>%
  ggplot(aes(x = year_reg, y = ln_rate_under5, color = small_city)) +
  geom_line() +
  geom_point() +  
  scale_x_continuous(breaks = seq(1985, 1995, by = 1)) +
  labs(x = "Year", y = "Under 5 Mortality (logged)") +
  scale_color_manual(values = c("gray50", "gray20")) +
  geom_vline(xintercept = 1991, linetype = "dashed") +
  theme(axis.text.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 15))


# Collapse data by specified variables
collapsed_data <- pipe_data %>%
  group_by(year_reg, small_city) %>%
  summarise(deaths_under5 = sum(deaths_under5),
            livebirths = sum(livebirths),
            .groups = "drop") %>% na.omit()


collapsed_data <- collapsed_data %>%
  mutate(rate_under5 = (deaths_under5 / livebirths) * 1000)


# Define labels for small_city variable
collapsed_data$small_city <- factor(collapsed_data$small_city, labels = c("Large Cities", "Small-Medium Sized Cities"))

# Plot the graph
plot_data3 <- collapsed_data %>%
  ggplot(aes(x = year_reg, y = rate_under5, color = small_city)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = seq(1985, 1995, by = 1)) +
  labs(x = "Year", y = "Under 5 Mortality") +
  scale_color_manual(values = c("gray50", "gray20")) + # Adjust the gray levels here
  geom_vline(xintercept = 1991, linetype = "dashed") +
  theme(axis.text.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 15))

# Replication of Figure 7

# Scatter plot with linear fit
pipe_filtered <- 
  pipe_data %>% 
  filter(rur < 1 & year_reg == 1990 & treated2 == 2)

figure_7 <- ggplot(pipe_filtered, aes(x = pipe_shr6090, y = ln_pipe)) +
  geom_point(shape = 15, color = "black") +
  geom_smooth(method = "lm", se = FALSE, color= "grey") +
  labs(x = "Piped Water Share 1960/1990", y = "Ln(Pipe Breaks/Km)") +
  theme(axis.text = element_text(size = 8), axis.title = element_text(size = 10)) +
  theme_minimal()
