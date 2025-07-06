# Write your MySQL query statement below
WITH cte AS (
SELECT buyer_id, COUNT(CASE WHEN YEAR(order_date) = 2019 THEN 1 END) AS orders_in_2019 FROM orders
GROUP BY buyer_id
)

SELECT user_id AS buyer_id, join_date, COALESCE(orders_in_2019, 0) AS orders_in_2019 FROM cte
RIGHT JOIN users u ON cte.buyer_id = u.user_id
;