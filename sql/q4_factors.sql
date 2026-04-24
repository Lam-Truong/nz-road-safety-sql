-- q4_factors.sql
-- Q4: What environmental factors are over-represented in fatal crashes?
WITH totals AS (
    SELECT
        weather
        , COUNT(*) AS total_crashes
        , SUM(CASE WHEN severity = 'Fatal Crash' THEN 1 ELSE 0 END) AS fatal_crashes
    FROM crashes_clean
    GROUP BY weather
)

, overall AS (
    SELECT
        1.0 * SUM(CASE WHEN severity = 'Fatal Crash' THEN 1 ELSE 0 END) / COUNT(*) AS base_line_fatality_rate
    FROM crashes_clean
)

SELECT
    *
    , 1.0 * fatal_crashes / total_crashes AS fatal_rate
    , ROUND(1.0 * fatal_crashes / total_crashes / o.base_line_fatality_rate, 2) AS relative_risk
FROM totals t, overall o
WHERE t.total_crashes >= 1000 and weather != 'Unknown'
ORDER BY relative_risk DESC


