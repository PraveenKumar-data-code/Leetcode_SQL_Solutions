SELECT product_name, s.year, price FROM sales s
JOIN product p ON s.product_id = p.product_id
;