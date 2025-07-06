SELECT e2.name AS Employee FROM Employee AS e,Employee AS e2 
WHERE e.id = e2.managerId AND e2.salary > e.salary
;