# Write your MySQL query statement below
SELECT  fun.c AS class FROM
(SELECT DISTINCT class AS c, COUNT(class) OVER(PARTITION BY class) AS cnt FROM Courses) fun
WHERE fun.cnt>=5;