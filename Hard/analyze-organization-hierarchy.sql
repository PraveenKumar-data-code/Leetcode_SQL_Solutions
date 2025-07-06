WITH RECURSIVE cte AS (
    SELECT employee_id, employee_name, 1 AS level FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.employee_name, level + 1 FROM cte
    JOIN employees e ON e.manager_id = cte.employee_id 
)
, hierarchy AS (
    SELECT 
        employee_id AS root_id,
        employee_id AS employee_id,
        salary
    FROM employees
    UNION ALL
    SELECT 
        h.root_id,
        e.employee_id,
        e.salary
    FROM hierarchy h
    JOIN employees e ON e.manager_id = h.employee_id
)

SELECT employee_id, employee_name, level, team_size, budget FROM cte c
JOIN (
SELECT root_id, COUNT(*) - 1 AS team_size, SUM(salary) AS budget FROM hierarchy
GROUP BY root_id) b ON c.employee_id = b.root_id
ORDER BY level ASC, budget DESC, employee_name ASC
;