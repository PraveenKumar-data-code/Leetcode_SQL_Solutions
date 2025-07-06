# Write your MySQL query statement below
SELECT id, num
FROM (
    SELECT id, COUNT(id) AS num
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id FROM RequestAccepted
    ) AS A
    GROUP BY id
) AS S
HAVING num = (SELECT MAX(num) FROM (SELECT id, COUNT(id) AS num FROM (SELECT requester_id AS id FROM RequestAccepted UNION ALL SELECT accepter_id AS id FROM RequestAccepted) AS A GROUP BY id) AS S);