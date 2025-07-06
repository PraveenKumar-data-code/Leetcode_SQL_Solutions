SELECT customer_id, COUNT(CASE WHEN transaction_id IS NULL THEN 1 END) AS count_no_trans FROM visits v
LEFT JOIN transactions t ON v.visit_id = t.visit_id
GROUP BY customer_id
HAVING COUNT(CASE WHEN transaction_id IS NULL THEN 1 END) > 0
;