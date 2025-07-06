# Write your MySQL query statement below
SELECT * FROM (
SELECT product_id, 'store1' AS store, store1 AS price FROM products
UNION ALL
SELECT product_id, 'store2' AS store, store2 AS store FROM products
UNION ALL
SELECT product_id, 'store3' AS store, store3 AS store FROM products) A
WHERE price IS NOT NULL