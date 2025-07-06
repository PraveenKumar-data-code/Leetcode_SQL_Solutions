# Write your MySQL query statement below
SELECT name FROM Employee
WHERE id IN (SELECT managerId FROM (SELECT managerId, COUNT(managerId) AS CNT FROM Employee
GROUP BY managerId
HAVING CNT >= 5) AS SUB)
;