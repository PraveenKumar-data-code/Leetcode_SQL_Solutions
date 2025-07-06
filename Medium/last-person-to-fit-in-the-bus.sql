# Write your MySQL query statement below
SELECT Name AS person_name FROM (SELECT turn AS Turn, person_id AS ID, person_name AS Name, weight AS Weight, SUM(weight) OVER(ORDER BY turn) AS good FROM Queue
ORDER BY turn
) AS SUB
WHERE good <= 1000
ORDER BY good DESC
LIMIT 1
;