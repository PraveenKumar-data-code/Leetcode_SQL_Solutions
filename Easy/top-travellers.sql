# Write your MySQL query statement below
SELECT name, travelled_distance FROM
(SELECT u.id, SUM(COALESCE(distance, 0)) AS travelled_distance FROM Users u
LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY u.id) a
JOIN Users u ON u.id = a.id
ORDER BY travelled_distance DESC, name ASC;