# Write your MySQL query statement below
WITH cte1 AS (
SELECT p.product_id, COUNT(*) AS cnt FROM Product p
JOIN Sales s ON p.product_id = s.product_id
WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31'
GROUP BY p.product_id
), cte2 AS (
SELECT product_id, COUNT(*) AS cnt FROM Sales
GROUP BY product_id
)
SELECT c.product_id, product_name FROM (
SELECT cte1.product_id FROM cte1
JOIN cte2 ON cte1.product_id = cte2.product_id AND cte1.cnt = cte2.cnt
) c
JOIN Product p ON p.product_id = c.product_id 
;