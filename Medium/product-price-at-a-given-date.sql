# Write your MySQL query statement below
WITH cte AS (
SELECT product_id, MAX(CASE WHEN '2019-08-16' >= change_date THEN change_date END) AS check_date FROM products
GROUP BY product_id
)

SELECT p.product_id, MAX(CASE WHEN change_date = check_date THEN new_price WHEN check_date IS NULL THEN 10 ELSE 0 END) AS price FROM products p
JOIN cte ON cte.product_id = p.product_id
GROUP BY p.product_id
;