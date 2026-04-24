-- q5_policy.sql
-- Q5: Did "Road to Zero" (launched 2019) change outcomes?
-- Compare 2015-2018 (pre) vs 2021-2024 (post). Skip 2019 (transition) and 2020 (COVID).
WITH cohorts AS (
    SELECT
        CASE 
            WHEN year BETWEEN 2015 AND 2018 THEN 'Pre-RtZ'
            WHEN year >= 2021 THEN 'Post-RtZ'
            ELSE 'Transition' END AS era
        , fatal_count
        , serious_count
    FROM crashes_clean
)

SELECT
    era
    , COUNT(*) AS total_crashes
    , SUM(fatal_count) AS deaths
    , ROUND(AVG(fatal_count) * 10000, 2) AS deaths_per_10k_crashes
    , SUM(serious_count) AS serious_injuries
    , ROUND(AVG(serious_count) * 10000, 2) AS serious_injuries_per_10k_crashes
FROM cohorts
WHERE era != 'Transition'
GROUP BY era
ORDER BY era;
