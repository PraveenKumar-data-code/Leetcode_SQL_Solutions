# Write your MySQL query statement below
WITH car AS
(
SELECT id, visit_date, people, LEAD(people, 1, 0) OVER(ORDER BY id) AS second_people, LEAD(people, 2, 0) OVER(ORDER BY id) AS third_people, LEAD(id, 1, 0) OVER(ORDER BY id) AS second_id, LEAD(id, 2, 0) OVER(ORDER BY id) AS third_id FROM stadium
), car2 AS (
SELECT id, visit_date, people, second_id, third_id FROM car
WHERE people >= 100 AND second_people >= 100 AND third_people >= 100 AND id + third_id = 2*second_id)

SELECT DISTINCT s.* FROM car2 c
JOIN stadium s ON c.id = s.id OR c.second_id = s.id OR c.third_id = s.id
ORDER BY s.visit_date ASC