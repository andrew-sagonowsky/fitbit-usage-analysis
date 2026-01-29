# fitbit-usage-analysis

## Business Task
Analyze smart device usage data to identify trends in activity, sleep, and daily habits, and apply insights to improve marketing strategy for the Bellabeat app.

## Dataset
FitBit Fitness Tracker Data (Kaggle, CC0 public domain)

## Tools
- R
- tidyverse
- ggplot2
- lubridate

## Key Insights
- Most user-days fall below the 10,000-step benchmark
- Activity levels are slightly higher on weekdays than weekends
- Daily steps strongly correlate with calories burned
- Higher activity does not strongly predict longer sleep duration

## Repository Structure
- `data/` – raw datasets
- `scripts/` – modular R scripts for cleaning, analysis, and visualization
- `figures/` – exported charts

## How to Run
Run the scripts in order:
1. `01_setup_and_import.R`
2. `02_clean_and_merge.R`
3. `03_analysis_and_insights.R`
4. `04_visualizations.R`
