# Write your MySQL query statement below
WITH a AS (
SELECT i.pid FROM insurance i
JOIN insurance t ON i.lat = t.lat AND i.lon = t.lon AND i.pid <> t.pid
), b AS (
    SELECT i.pid, i.tiv_2016 FROM insurance i
    JOIN insurance n ON i.tiv_2015 = n.tiv_2015 AND i.pid <> n.pid
    WHERE i.pid NOT IN (SELECT pid FROM a)
)

SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM (SELECT DISTINCT * FROM b) M
;