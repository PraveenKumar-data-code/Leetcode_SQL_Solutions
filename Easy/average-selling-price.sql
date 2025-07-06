# Write your MySQL query statement below
SELECT TAB1.product_id AS product_id, COALESCE(ROUND(TAB1.product/TAB2.SUM, 2), 0) AS average_price
FROM (
  SELECT product_id, SUM(product) AS product
   FROM (
     SELECT Prices.product_id AS product_id,  COALESCE(UnitsSold.units*Prices.price, 0) AS product
      FROM Prices
      LEFT JOIN UnitsSold 
      ON 
      Prices.product_id = UnitsSold.product_id AND 
      UnitsSold.purchase_date >= Prices.start_date AND 
      UnitsSold.purchase_date <= Prices.end_date)
  AS SUB
GROUP BY product_id
) AS TAB1
LEFT JOIN (
  SELECT product_id, SUM(units) AS SUM 
  FROM UnitsSold
  GROUP BY product_id) AS TAB2
ON TAB1.product_id = TAB2.product_id 
;