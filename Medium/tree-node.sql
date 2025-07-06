# Write your MySQL query statement below
WITH cte AS (
    SELECT a.id AS a_id, b.id AS b_id FROM Tree a
    JOIN Tree b ON a.id = b.p_id
), leaf AS(
SELECT b_id FROM cte
WHERE b_id NOT IN (SELECT DISTINCT a_id FROM cte))
, inner_nodes AS (
    SELECT b_id FROM cte
    WHERE b_id IN (SELECT DISTINCT a_id FROM cte)
)
SELECT id, CASE WHEN id IN (SELECT * FROM inner_nodes) THEN 'Inner'
WHEN id IN (SELECT * FROM leaf) THEN 'Leaf'
ELSE 'Root' END AS type FROM Tree
;