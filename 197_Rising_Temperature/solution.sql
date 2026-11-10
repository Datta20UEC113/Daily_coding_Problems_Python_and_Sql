-- LeetCode 197: Rising Temperature (PostgreSQL)
SELECT today.id AS id
FROM Weather AS today
JOIN Weather AS yesterday
    ON today.recordDate = yesterday.recordDate + 1
WHERE today.temperature > yesterday.temperature;

-- Alternative using LAG():
-- WITH history AS (
--     SELECT id, recordDate, temperature,
--            LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date,
--            LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp
--     FROM Weather
-- )
-- SELECT id FROM history
-- WHERE recordDate = prev_date + 1
--   AND temperature > prev_temp;
