# Write your MySQL query statement below
SELECT TAB2.employee_id, TAB1.name, TAB2.reports_count, TAB2.average_age FROM Employees AS TAB1
JOIN
(SELECT reports_to AS employee_id, COUNT(reports_to) AS reports_count, ROUND(AVG(age)) AS average_age
FROM Employees
GROUP BY reports_to
HAVING reports_to IS NOT NULL) AS TAB2
ON TAB1.employee_id = TAB2.employee_id
ORDER BY TAB2.employee_id
;