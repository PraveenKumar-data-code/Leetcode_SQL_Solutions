# Write your MySQL query statement below
SELECT Project.project_id, ROUND(AVG(COALESCE(Employee.experience_years)), 2) AS average_years FROM Project
LEFT JOIN Employee 
ON COALESCE(Project.employee_id, 0) = Employee.employee_id
GROUP BY Project.project_id;