#!/bin/bash
# download_data.sh
# Downloads the raw data files needed to reproduce this project.
#
# Usage: bash download_data.sh
#
# Requirements: curl (pre-installed on Mac/Linux; use Git Bash on Windows)

mkdir -p data

# ------------------------------------------------------------------------------
# Dataset 1: Waka Kotahi CAS Crash Data
# Source: https://opendata-nzta.opendata.arcgis.com/datasets/NZTA::crash-analysis-system-cas-data-1/about
# ------------------------------------------------------------------------------
echo "Downloading CAS crash data (~400-600 MB, this may take a few minutes)..."

curl -L -o data/Crash_Analysis_System__CAS__data.csv \
  "https://opendata-nzta.opendata.arcgis.com/datasets/NZTA::crash-analysis-system-cas-data-1/about"

echo "CAS data saved to data/Crash_Analysis_System__CAS__data.csv"

# ------------------------------------------------------------------------------
# Dataset 2: Stats NZ Regional Population Estimates
# Source: https://www.stats.govt.nz/information-releases/subnational-population-estimates-at-30-june-2024/
#
# NOTE: Stats NZ does not provide a direct CSV download link.
# Please follow these manual steps:
#   1. Go to the URL above
#   2. Download the Excel file under "Download data"
#   3. Open the Excel file and locate the regional population sheet
#   4. Copy the following columns for all NZ regions:
#      Region, population_2018, population_2023, population_2024, population_2025
#   5. Paste into a new sheet and export as CSV
#   6. Save as: data/statsnz_regional_population.csv
#
# Expected format (comma-separated, with header row):
#   Region,population_2018,population_2023,population_2024,population_2025
#   Northland region,"185,800","198,500","200,400","201,100"
#   Auckland region,"1,654,800","1,755,200","1,798,300","1,816,000"
#   ...
# ------------------------------------------------------------------------------
echo ""
echo "---------------------------------------------------------------------"
echo "ACTION REQUIRED: Stats NZ population data must be downloaded manually."
echo "See instructions above or in the README under 'Data Notes'."
echo "Save the file to: data/statsnz_regional_population.csv"
echo "---------------------------------------------------------------------"
