# Write your MySQL query statement below
SELECT name, bonus FROM (SELECT Employee.name AS name, Bonus.bonus AS bonus FROM Employee
LEFT JOIN Bonus 
ON Employee.empId = Bonus.empId) AS sub
WHERE bonus < 1000 OR bonus IS NULL
;