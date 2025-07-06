# Write your MySQL query statement below
SELECT Id FROM (SELECT id, recordDate, COALESCE(LAG(recordDate, 1) OVER(), 0) AS new_date, temperature, 
COALESCE(LAG(temperature,1) OVER(), 0) AS new_temp FROM Weather
ORDER BY recordDate) AS SUB
WHERE DATEDIFF(recordDate, new_date) = 1 AND temperature > new_temp
;