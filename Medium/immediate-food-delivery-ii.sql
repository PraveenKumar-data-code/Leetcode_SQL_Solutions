# Write your MySQL query statement below
SELECT ROUND((SUM(req)/COUNT(req))*100, 2) AS immediate_percentage FROM 
(SELECT CASE WHEN m_d = c_d THEN 1
ELSE 0
END AS req FROM
(SELECT T.delivery_id AS d_id, T2.customer_id AS c_id, T2.min_date AS m_d, T.customer_pref_delivery_date AS c_d
FROM Delivery T
JOIN
(
SELECT customer_id, MIN(order_date) AS min_date FROM Delivery 
GROUP BY customer_id
) AS T2
ON T.customer_id = T2.customer_id AND T.order_date = T2.min_date
) AS SUB) AS sub2
;