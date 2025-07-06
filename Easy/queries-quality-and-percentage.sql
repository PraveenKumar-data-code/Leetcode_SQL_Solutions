# Write your MySQL query statement below
SELECT TAB3.query_name AS query_name, TAB3.quality, TAB4.poor_query_percentage
 FROM (
   SELECT q.query_name AS query_name, ROUND(AVG(q.rating/q.position), 2) AS quality 
   FROM Queries AS q
   GROUP BY q.query_name
   ) AS TAB3
JOIN 
(
  SELECT TAB2.query_name AS query_name, ROUND((COALESCE(TAB1.NUM, 0)/TAB2.total)*100, 2) AS poor_query_percentage 
  FROM (
    SELECT q.query_name AS query_name, COALESCE(COUNT(*), 0) AS NUM FROM Queries AS q
    WHERE q.rating < 3
    GROUP BY q.query_name
    ) AS TAB1
  RIGHT JOIN 
  (
    SELECT q.query_name AS query_name, COUNT(*) AS total FROM Queries as q
    GROUP BY q.query_name
  ) AS TAB2
  ON TAB1.query_name = TAB2.query_name
) AS TAB4
ON TAB3.query_name = TAB4.query_name
;