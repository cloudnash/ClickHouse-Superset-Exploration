-- Count total rows in web_logs
SELECT count() FROM web_logs;

-- Retrieve all data
SELECT * FROM web_logs;

-- Filter logs with status 200
SELECT * FROM web_logs WHERE status = 200;

-- Order by timestamp
SELECT * FROM web_logs ORDER BY ts DESC;
