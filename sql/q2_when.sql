-- q2_when.sql
-- Q2: When are fatal crashes most likely?
SELECT
    CASE WHEN holiday_flag = 'Normal day' THEN 'Normal day'
         ELSE 'Holiday period' END AS period_type,
    COUNT(*) AS crashes,
    SUM(serious_count) AS serious_crashes,
    SUM(fatal_count) AS deaths,
    ROUND(100.0 * SUM(serious_count) / COUNT(*) , 2) AS serious_rate_pct,
    ROUND(100.0 * SUM(fatal_count) / COUNT(*), 2) AS fatality_rate_pct,
    100 - ROUND(100.0 * SUM(serious_count) / COUNT(*), 2) - ROUND(100.0 * SUM(fatal_count) / COUNT(*), 2) AS light_rate_pct 
FROM crashes_clean
GROUP BY period_type
ORDER BY fatality_rate_pct DESC;
