library(tidyverse)
library(lubridate)

# Load cleaned + merged data
source("scripts/02_clean_and_merge.R")

# Create output folder if it doesn't exist
if (!dir.exists("figures")) dir.create("figures")

# -----------------------------
# Chart 1: Steps distribution
# -----------------------------
p1 <- ggplot(daily_master, aes(x = TotalSteps)) +
  geom_histogram(
    binwidth = 1000,
    fill = "#4C72B0",      
    color = "white"
  ) +
  labs(
    title = "Distribution of Daily Step Counts",
    subtitle = "Most days fall below the 10,000-step benchmark",
    x = "Daily Steps",
    y = "Frequency"
  ) +
  theme_minimal(base_size = 12)

ggsave(
  "figures/chart1_steps_distribution.png",
  p1,
  width = 9,
  height = 5,
  dpi = 300
)

ggsave("figures/chart1_steps_distribution.png", p1, width = 9, height = 5, dpi = 300)

# -----------------------------------
# Chart 2: Average steps by DayType
# -----------------------------------
p2_data <- daily_master %>%
  group_by(DayType) %>%
  summarise(avg_steps = mean(TotalSteps, na.rm = TRUE), .groups = "drop")

p2 <- ggplot(p2_data, aes(x = DayType, y = avg_steps, fill = DayType)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = round(avg_steps, 0)), vjust = -0.5, size = 4) +
  labs(
    title = "Average Daily Steps by Day Type",
    subtitle = "Slightly higher activity on weekdays suggests routine-driven movement",
    x = "Day Type",
    y = "Average Daily Steps"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("figures/chart2_weekday_vs_weekend.png", p2, width = 7, height = 5, dpi = 300)

# -------------------------------------
# Chart 3: Steps vs calories 
# -------------------------------------

p3 <- daily_master %>%
  filter(TotalSteps > 0) %>%
  ggplot(aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.35, color = "#55A868") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  coord_cartesian(xlim = c(0, 25000), ylim = c(0, 5200)) +
  labs(
    title = "Relationship Between Daily Steps and Calories Burned",
    subtitle = "Calories burned increase as daily step counts rise",
    x = "Daily Steps",
    y = "Calories Burned"
  ) +
  theme_minimal(base_size = 12)

# ------------------------------------------
# Chart 4: Steps vs sleep duration (sleep days)
# ------------------------------------------
p4 <- daily_master %>%
  filter(!is.na(TotalMinutesAsleep)) %>%
  ggplot(aes(x = TotalSteps, y = TotalMinutesAsleep)) +
  geom_point(alpha = 0.35, color = "#C44E52") +   
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  coord_cartesian(xlim = c(0, 25000), ylim = c(0, 900)) +
  labs(
    title = "Daily Steps vs Sleep Duration",
    subtitle = "Higher daily activity does not strongly predict longer sleep",
    x = "Daily Steps",
    y = "Minutes Asleep"
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/chart4_steps_vs_sleep.png", p4, width = 6, height = 7, dpi = 300)

# Print a quick confirmation
cat("Saved charts to /figures:\n",
    "- chart1_steps_distribution.png\n",
    "- chart2_weekday_vs_weekend.png\n",
    "- chart3_steps_vs_calories.png\n",
    "- chart4_steps_vs_sleep.png\n")
