# Write your MySQL query statement below
SELECT TAB1.product_name, TAB2.sum AS unit FROM Products AS TAB1
JOIN
(SELECT O.product_id AS product_id, DATE_FORMAT(O.order_date, '%Y-%m') AS date, SUM(O.unit) AS sum FROM Products AS P
JOIN Orders AS O
ON P.product_id = O.product_id
GROUP BY O.product_id, date
HAVING date = '2020-02' AND sum >= 100) AS TAB2
ON TAB1.product_id = TAB2.product_id
;