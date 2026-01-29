library(tidyverse)
library(lubridate)
library(janitor)

source("scripts/01_setup_and_import.R")

# Clean daily activity
daily_activity_clean <- dailyActivity_merged %>%
  mutate(
    ActivityDate = mdy(ActivityDate),
    DayType = if_else(wday(ActivityDate) %in% c(1, 7), "Weekend", "Weekday"),
    TotalActiveMinutes = VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes
  ) %>%
  distinct()

# Clean sleep data
sleep_clean <- sleepDay_merged %>%
  mutate(
    SleepDay = as.character(SleepDay),
    ActivityDate = as.Date(mdy_hms(SleepDay))
  ) %>%
  distinct() %>%
  select(Id, ActivityDate, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed)

# Merge
daily_master <- daily_activity_clean %>%
  left_join(sleep_clean, by = c("Id", "ActivityDate"))
