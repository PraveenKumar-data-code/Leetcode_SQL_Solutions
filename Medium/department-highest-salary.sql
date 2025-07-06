SELECT Department,Employee,Salary FROM
(SELECT Department.name AS Department, Employee.name AS Employee,
DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS 'rank',
Employee.salary AS Salary
FROM Employee
JOIN Department ON Employee.departmentId = Department.id) qp
WHERE qp.rank<2;