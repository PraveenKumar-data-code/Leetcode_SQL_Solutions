# Write your MySQL query statement below
SELECT DISTINCT num AS ConsecutiveNums FROM (
    SELECT num, LEAD(num, 1) OVER() AS l1, LEAD(num, 2) OVER() AS l2 FROM Logs
) a
WHERE num = l1 AND l1 = l2