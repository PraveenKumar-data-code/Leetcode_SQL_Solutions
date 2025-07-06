# Write your MySQL query statement below
SELECT employee_id FROM
(SELECT Salaries.employee_id AS employee_id FROM Salaries
WHERE 
     Salaries.employee_id NOT IN 
     (
         SELECT employee_id FROM Employees
     )
UNION
SELECT Employees.employee_id AS employee_id FROM Employees
WHERE 
     Employees.employee_id NOT IN 
     (
         SELECT employee_id FROM Salaries
     )
 ) qp
 ORDER BY employee_id ASC
     ;