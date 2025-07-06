# Write your MySQL query statement below
SELECT p.category AS category, COALESCE(s.accounts_count, 0) AS accounts_count FROM (
  SELECT 'High Salary' AS category 
  UNION
  SELECT 'Average Salary' AS category
  UNION 
  SELECT 'Low Salary' AS category
) AS p
LEFT JOIN
(SELECT category, COUNT(*) AS accounts_count FROM (SELECT income, CASE 
 WHEN income < 20000 THEN 'Low Salary'
 WHEN income >= 20000 AND income <= 50000 THEN 'Average Salary'
 ELSE 'High Salary'
 END AS category FROM Accounts) AS Q
 GROUP BY category) AS s
ON p.category = s.category
 ;