# Write your MySQL query statement below
SELECT 
CASE
   WHEN COUNT(DISTINCT salary) = 1
THEN NULL
ELSE (SELECT DISTINCT salary
FROM Employee
WHERE salary<
      (
SELECT DISTINCT salary 
FROM Employee
ORDER BY salary DESC
LIMIT 1) 
ORDER BY salary DESC
LIMIT 1)  
   END 
AS SecondHighestSalary
FROM Employee