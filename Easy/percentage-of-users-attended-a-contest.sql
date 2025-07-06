# Write your MySQL query statement below
SELECT contest_id, ROUND((SUM1/CNT)*100, 2) AS percentage 
FROM (
  SELECT contest_id, (SELECT COUNT(*) FROM Users) AS CNT, COUNT(user_id) AS SUM1 
  FROM Register
  GROUP BY contest_id, CNT) AS TAB1
ORDER BY percentage DESC, contest_id
;