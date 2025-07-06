# Write your MySQL query statement below
(SELECT U.name AS results FROM Users U
JOIN
(SELECT user_id, COUNT(*) AS cnt FROM MovieRating
GROUP BY user_id) AS M
ON U.user_id = M.user_id
ORDER BY M.cnt DESC, U.name
LIMIT 1)
UNION ALL
(SELECT MO.title AS results FROM Movies MO
JOIN
(
  SELECT movie_id, DATE_FORMAT(created_at, '%Y-%m') AS date1, AVG(rating) AS avg1 FROM MovieRating
  GROUP BY movie_id, date1
  HAVING date1 = '2020-02'
) AS M
ON MO.movie_id = M.movie_id
ORDER BY M.avg1 DESC, MO.title
LIMIT 1)
;