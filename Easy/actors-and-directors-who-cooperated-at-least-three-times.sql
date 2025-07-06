# Write your MySQL query statement below
WITH REQ_CTE AS (
SELECT actor_id , director_id , COUNT(1) AS cnt FROM ActorDirector 
GROUP BY 1 , 2 
HAVING COUNT(1) >= 3 )

SELECT actor_id , director_id FROM REQ_CTE;