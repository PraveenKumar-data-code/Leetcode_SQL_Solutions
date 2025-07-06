# Write your MySQL query statement below
WITH c AS (
SELECT log_id AS id, ip, IF(LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) = 3, 0, 1) AS third_condition FROM logs
), a AS (
    SELECT c.id, COALESCE(CASE 
    WHEN third_condition = 0 AND CAST(SUBSTRING_INDEX(c.ip, '.', 1) AS UNSIGNED) > 255 THEN 1
    WHEN third_condition = 0 AND CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 2), '.', -1) AS UNSIGNED) > 255 THEN 1
    WHEN third_condition = 0 AND CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 3), '.', -1) AS UNSIGNED) > 255 THEN 1
    WHEN third_condition = 0 AND CAST(SUBSTRING_INDEX(c.ip, '.', -1) AS UNSIGNED) > 255 THEN 1
    END, 0) AS first_condition FROM c  
), b AS (
    SELECT c.id, COALESCE(CASE WHEN SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 1), '.', -1), 1, 1) = '0' OR SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 2), '.', -1), 1, 1) = '0' OR
    SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 3), '.', -1), 1, 1) = '0' OR
    SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(c.ip, '.', 4), '.', -1), 1, 1) = '0' THEN 1
    END, 0) AS second_condition
    FROM c
)
SELECT ip, SUM(IF(first_condition + second_condition + third_condition > 0, 1, 0)) AS invalid_count FROM c
JOIN b ON b.id = c.id
JOIN a ON a.id = c.id
GROUP BY ip
HAVING invalid_count > 0
ORDER BY invalid_count DESC, ip DESC
;