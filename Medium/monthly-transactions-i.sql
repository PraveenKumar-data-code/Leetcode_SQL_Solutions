# Write your MySQL query statement below
SELECT TAB1.month, TAB1.country, TAB1.trans_count, COALESCE(TAB2.approved_count, 0) AS approved_count, TAB1.trans_total_amount, COALESCE(TAB2.approved_total_amount, 0) AS approved_total_amount FROM
(SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(state) AS trans_count, SUM(amount) AS trans_total_amount FROM Transactions
GROUP BY month, country) AS TAB1
LEFT JOIN
(SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, state, COUNT(state) AS approved_count, SUM(amount) AS approved_total_amount FROM Transactions
GROUP BY month, country, state
HAVING state = 'approved') AS TAB2
ON TAB1.month = TAB2.month AND TAB1.country = TAB2.country

# SELECT EXTRACT(MONTH FROM trans_date) AS month, country,  FROM Transactions
# GROUP BY month, country
;