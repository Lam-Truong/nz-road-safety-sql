-- 02_clean.sql
-- Create a tidied VIEW rather than mutating source data.
CREATE OR REPLACE VIEW crashes_clean AS
SELECT
    crashYear AS year,
    COALESCE(NULLIF(NULLIF(TRIM(region), ''), 'Null'), 'Unknown') AS region,
    COALESCE(NULLIF(NULLIF(TRIM(tlaName), ''), 'Null'), 'Unknown') AS tla,
    COALESCE(NULLIF(NULLIF(TRIM(crashSeverity), ''), 'Null'), 'Unknown') AS severity,
    COALESCE(NULLIF(NULLIF(TRIM(weatherA), ''), 'Null'), 'Unknown') AS weather,
    COALESCE(NULLIF(NULLIF(TRIM(light), ''), 'Null'), 'Unknown') AS light,
    speedLimit AS speed_limit,
    COALESCE(fatalCount, 0) AS fatal_count,
    COALESCE(seriousInjuryCount, 0) AS serious_count,
    COALESCE(minorInjuryCount, 0) AS minor_count,
    COALESCE(NULLIF(NULLIF(TRIM(holiday), ''), 'Null'), 'Normal day') AS holiday_flag
FROM crashes
WHERE crashYear BETWEEN 2015 AND 2024;
