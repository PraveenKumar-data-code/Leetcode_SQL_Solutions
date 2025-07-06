# Write your MySQL query statement below
WITH car AS (
SELECT user_id, category FROM ProductPurchases p
JOIN ProductInfo i ON p.product_id = i.product_id
) 
SELECT c1.category AS category1, c2.category AS category2, 
COUNT(DISTINCT c1.user_id) AS customer_count FROM car c1
JOIN car c2 ON c1.category < c2.category AND c1.user_id = c2.user_id
GROUP BY category1, category2
HAVING customer_count > 2
ORDER BY customer_count DESC, category1 ASC, category2 ASC