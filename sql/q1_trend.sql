-- q1_trend.sql
-- Q1: Is NZ road safety improving over time?
-- Finding: [fill in after running]
WITH yearly AS (
    SELECT year,
           COUNT(*) AS total_crashes,
           SUM(fatal_count) AS deaths,
           SUM(serious_count) AS serious_injuries
    FROM crashes_clean
    GROUP BY year
)

SELECT
    year
    , total_crashes
    , deaths
    , serious_injuries
    , LAG(deaths) OVER(ORDER BY year) AS previous_year_deaths
    , deaths - LAG(deaths) OVER(ORDER BY year) AS deaths_change
    , CAST(deaths - LAG(deaths) OVER(ORDER BY year) AS FLOAT) *100 / NULLIF(LAG(deaths) OVER(ORDER BY year), 0) AS deaths_pct_change
FROM yearly
ORDER BY year
;
