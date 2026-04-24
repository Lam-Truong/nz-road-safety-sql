WITH cohorts AS (
    SELECT
        CASE 
            WHEN year BETWEEN 2015 AND 2018 THEN 'Pre-RtZ'
            WHEN year >= 2021 THEN 'Post-RtZ'
            ELSE 'Transition' END AS era
        , CASE
            WHEN speed_limit >= 100 THEN 'High Way'
            ELSE 'City Street' END AS road_type
        , fatal_count
        , serious_count
    FROM crashes_clean
)

SELECT
    era
    , road_type
    , COUNT(*) AS total_crashes
    , SUM(fatal_count) AS deaths
    , ROUND(AVG(fatal_count) * 10000, 2) AS deaths_per_10k_crashes
    , SUM(serious_count) AS serious_injuries
    , ROUND(AVG(serious_count) * 10000, 2) AS serious_injuries_per_10k_crashes
FROM cohorts
WHERE era != 'Transition'
GROUP BY era, road_type
ORDER BY road_type, era;