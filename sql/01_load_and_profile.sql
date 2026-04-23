-- 01_load_and_profile.sql
-- Load the CAS CSV directly with DuckDB. No ETL needed.
CREATE OR REPLACE TABLE crashes AS
SELECT *
FROM read_csv_auto(
    'data/Crash_Analysis_System__CAS__data.csv',
    header=true,
    sample_size=-1
);

-- How many rows?
SELECT COUNT(*) AS total_crashes FROM crashes;

-- What years are covered?
SELECT MIN(crashYear) AS first_year,
       MAX(crashYear) AS last_year,
       COUNT(DISTINCT crashYear) AS year_count
FROM crashes;

-- Which columns have nulls? (handles both real NULLs and text "Null")
-- Run via Python in the notebook using the dynamic null-count approach
