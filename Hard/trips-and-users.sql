# Write your MySQL query statement below
WITH c AS (
SELECT client_id, driver_id, status, request_at FROM trips t
JOIN (
SELECT users_id FROM users
WHERE banned LIKE 'No' AND role = 'client'
) a ON t.client_id = a.users_id
JOIN (
    SELECT users_id FROM users
    WHERE banned LIKE 'No' AND role= 'driver'
) b ON t.driver_id = b.users_id
WHERE client_id IS NOT NULL AND driver_id IS NOT NULL AND request_at BETWEEN '2013-10-01' AND '2013-10-03')
SELECT request_at AS Day, ROUND(COUNT(CASE WHEN status = "cancelled_by_client" OR status = "cancelled_by_driver" THEN 1 END)/COUNT(*), 2) AS 'Cancellation Rate' FROM c
GROUP BY request_at