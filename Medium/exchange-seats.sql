# Write your MySQL query statement below
SELECT id AS id,
CASE
WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 <> 0
THEN student

WHEN id % 2 = 0 
THEN LAG(student) OVER()

ELSE LEAD(student) OVER()

END AS student
FROM Seat;