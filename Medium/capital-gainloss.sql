# Write your MySQL query statement below
SELECT stock_name, SUM(price) AS capital_gain_loss FROM (
SELECT stock_name, CASE WHEN operation = 'Buy' THEN -price ELSE price END AS price FROM Stocks) A
GROUP BY stock_name
;