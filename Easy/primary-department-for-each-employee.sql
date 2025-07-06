# Write your MySQL query statement below
SELECT employee_id, department_id FROM (SELECT TAB1.employee_id AS employee_id, TAB1.department_id AS department_id, TAB2.cnt, TAB1.primary_flag FROM Employee AS TAB1
JOIN
(SELECT employee_id, COUNT(employee_id) AS cnt FROM Employee
GROUP BY employee_id) AS TAB2
ON TAB1.employee_id = TAB2.employee_id
HAVING (TAB2.cnt > 1 AND TAB1.primary_flag = 'Y') OR (TAB2.cnt = 1)
) AS TAB3
;