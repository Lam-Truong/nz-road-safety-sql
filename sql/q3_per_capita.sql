-- q3_per_capita.sql
-- Q3: Which regions are the most dangerous per capita?

-- Load Stats NZ regional population as a second table

/*
CREATE OR REPLACE TABLE population AS
SELECT
    Region as region,
    CAST(REPLACE(population_2018, ',', '') AS INTEGER) AS population_2018,
    CAST(REPLACE(population_2023, ',', '') AS INTEGER) AS population_2023,
    CAST(REPLACE(population_2024, ',', '') AS INTEGER) AS population_2024,
    CAST(REPLACE(population_2025, ',', '') AS INTEGER) AS population_2025
FROM read_csv_auto('data/statsnz_regional_population.csv', header=true);
*/

WITH deaths_by_region AS (
    SELECT 
        REPLACE(region, 'Region', 'region') AS region, 
        SUM(fatal_count) AS total_deaths
    FROM crashes_clean
    WHERE year BETWEEN 2020 AND 2024
    GROUP BY region
)
SELECT d.region,
       d.total_deaths,
       p.population_2023,
       ROUND(100000.0 * d.total_deaths / p.population_2023, 2) AS deaths_per_100k,
       RANK() OVER (ORDER BY 100000.0 * d.total_deaths / p.population_2023 DESC) AS rank_per_capita
FROM deaths_by_region d
JOIN population p
ON d.region = p.region
ORDER BY rank_per_capita;
