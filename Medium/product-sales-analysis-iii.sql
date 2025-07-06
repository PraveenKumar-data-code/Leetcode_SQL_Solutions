# Write your MySQL query statement below
SELECT U.product_id, U.first_year, S.quantity, S.price FROM Sales S
JOIN(
SELECT product_id, MIN(year) AS first_year FROM Sales
GROUP BY product_id
) AS U
ON S.product_id = U.product_id AND S.year = U.first_year
;