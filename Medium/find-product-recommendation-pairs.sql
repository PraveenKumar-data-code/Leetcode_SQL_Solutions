# Write your MySQL query statement below
WITH cte AS (
    SELECT p1.product_id AS product1_id, p2.product_id AS product2_id,
    COUNT(*) AS customer_count
    FROM ProductPurchases p1
    JOIN ProductPurchases p2 ON p1.product_id < p2.product_id AND p1.user_id = p2.user_id
    GROUP BY p1.product_id, p2.product_id
    HAVING COUNT(*) > 2
)

SELECT product1_id, product2_id, p1.category AS product1_category, p2.category AS product2_category, customer_count FROM cte
JOIN ProductInfo p1 ON cte.product1_id = p1.product_id 
JOIN ProductInfo p2 ON cte.product2_id = p2.product_id
ORDER BY customer_count DESC, product1_id ASC, product2_id ASC
;