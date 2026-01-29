library(tidyverse)
library(lubridate)

# Load the cleaned + merged dataset
source("scripts/02_clean_and_merge.R")

# 1) Overall averages
overall_avgs <- daily_master %>%
  summarise(
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    avg_calories = mean(Calories, na.rm = TRUE),
    avg_active_minutes = mean(TotalActiveMinutes, na.rm = TRUE)
  )

print(overall_avgs)

# 2) Weekday vs weekend comparison
weekday_weekend <- daily_master %>%
  group_by(DayType) %>%
  summarise(
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    avg_active_minutes = mean(TotalActiveMinutes, na.rm = TRUE),
    avg_calories = mean(Calories, na.rm = TRUE),
    .groups = "drop"
  )

print(weekday_weekend)

# 3) Steps vs sleep correlation (sleep days only)
steps_sleep_cor <- daily_master %>%
  filter(!is.na(TotalMinutesAsleep)) %>%
  summarise(cor_steps_sleep = cor(TotalSteps, TotalMinutesAsleep))

print(steps_sleep_cor)
