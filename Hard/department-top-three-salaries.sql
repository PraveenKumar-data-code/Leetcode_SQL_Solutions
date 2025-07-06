# Write your MySQL query statement below
SELECT Department,Employee,Salary FROM
(SELECT Department.name AS Department, Employee.name AS Employee,Employee.salary AS Salary,
DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS 'rank'
FROM Employee
JOIN Department ON Employee.departmentId = Department.id) QP
WHERE QP.rank < 4;