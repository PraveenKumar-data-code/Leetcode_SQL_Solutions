WITH cte AS
(SELECT DISTINCT * FROM (
SELECT customer_id, c.product_key AS cpk, p.product_key AS ppk FROM Customer c
JOIN Product p ON c.product_key = p.product_key
) C
ORDER BY customer_id)
SELECT customer_id FROM (
SELECT customer_id, COUNT(*) AS cnt FROM cte
GROUP BY customer_id
HAVING cnt = (SELECT COUNT(*) FROM Product)
) C
;