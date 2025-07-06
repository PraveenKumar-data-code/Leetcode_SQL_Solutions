WITH NumberedRows AS (
  SELECT
    visited_on,
    SUM(amount) AS amount,
    ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
  FROM Customer
  GROUP BY visited_on
)
SELECT visited_on, amount, ROUND(amount/7, 2) AS average_amount FROM (SELECT u.visited_on AS visited_on, CASE 
WHEN b.row_num > 7 THEN u.amount - b.amount
ELSE u.amount
END AS amount FROM
(SELECT visited_on, amount, row_num FROM (SELECT n.visited_on AS visited_on, SUM(n.amount) OVER(ORDER BY n.visited_on) AS amount, n.row_num AS row_num FROM NumberedRows n
ORDER BY n.visited_on) AS m
WHERE row_num >= 7) AS u
LEFT JOIN
(SELECT visited_on, SUM(amount) OVER(ORDER BY visited_on) AS amount, row_num + 7 AS row_num FROM NumberedRows
WHERE row_num <=
(SELECT count(*) FROM NumberedRows
WHERE row_num > 7)) AS b
ON u.row_num = b.row_num) AS h
ORDER BY visited_on
;