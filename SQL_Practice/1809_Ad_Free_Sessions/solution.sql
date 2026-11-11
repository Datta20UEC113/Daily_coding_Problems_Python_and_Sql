-- 1809 — Ad-Free Sessions
SELECT p.session_id
FROM Playback AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM Ads AS a
    WHERE a.customer_id = p.customer_id
      AND a.timestamp BETWEEN p.start_time AND p.end_time
);
