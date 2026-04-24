-- q1_trend.sql
-- Q1: Is NZ road safety improving over time?
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
    , total_crashes - LAG(total_crashes) OVER(ORDER BY year) AS total_crashes_change
    , CAST(total_crashes - LAG(total_crashes) OVER(ORDER BY year) AS FLOAT) *100 
    / NULLIF(LAG(total_crashes) OVER(ORDER BY year), 0) AS total_crashes_pct_change
    , serious_injuries - LAG(serious_injuries) OVER(ORDER BY year) AS serious_injuries_change
    , CAST(serious_injuries - LAG(serious_injuries) OVER(ORDER BY year) AS FLOAT) *100 
    / NULLIF(LAG(serious_injuries) OVER(ORDER BY year), 0) AS serious_injuries_pct_change
    , deaths - LAG(deaths) OVER(ORDER BY year) AS deaths_change
    , CAST(deaths - LAG(deaths) OVER(ORDER BY year) AS FLOAT) *100 
    / NULLIF(LAG(deaths) OVER(ORDER BY year), 0) AS deaths_pct_change
FROM yearly
ORDER BY year
;
