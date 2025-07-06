# Write your MySQL query statement below
WITH cte AS (
SELECT DISTINCT * FROM (SELECT date_id, make_name, lead_id FROM DailySales) s ), sol1 AS (
SELECT date_id, make_name, COUNT(*) AS unique_leads FROM cte
GROUP BY 1,2
ORDER BY 1
), cte2 AS (
SELECT DISTINCT * FROM (SELECT date_id, make_name, partner_id FROM DailySales) s
), sol2 AS (
SELECT date_id, make_name, COUNT(*) AS unique_partners FROM cte2
GROUP BY 1,2
ORDER BY 1
)
SELECT sol1.*, unique_partners FROM sol2
JOIN sol1 ON sol1.date_id = sol2.date_id AND sol1.make_name = sol2.make_name
;