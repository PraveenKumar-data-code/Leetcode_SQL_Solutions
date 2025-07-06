# Write your MySQL query statement below
SELECT employee_id FROM (SELECT employee_id, manager_id, salary FROM Employees
WHERE salary < 30000 AND manager_id NOT IN (SELECT employee_id FROM Employees)) AS TAB
ORDER BY employee_id
;