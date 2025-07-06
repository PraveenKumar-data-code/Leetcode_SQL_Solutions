# Write your MySQL query statement below
SELECT S.user_id, COALESCE(SAB.confirmation_rate, 0) AS confirmation_rate FROM Signups S
LEFT JOIN
(SELECT user_id, ROUND((sum_confirm/(sum_confirm + sum_timeout)), 2) AS confirmation_rate FROM
(SELECT user_id, SUM(confirmed) AS sum_confirm, SUM(timeout) AS sum_timeout FROM
(SELECT user_id, time_stamp,
 CASE action
 WHEN 'confirmed' THEN 1
 ELSE 0
 END AS confirmed,
 CASE action
 WHEN 'timeout' THEN 1
 ELSE 0
 END AS timeout
FROM Confirmations
) AS SUB
GROUP BY user_id) AS TAB
GROUP BY user_id) AS SAB 
ON S.user_id = SAB.user_id
;