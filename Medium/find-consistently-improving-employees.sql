# Write your MySQL query statement below
WITH fil1 AS 
(
    SELECT employee_id, COUNT(*) FROM performance_reviews
    GROUP BY employee_id
    HAVING COUNT(*) >= 3
), fil2 AS (
    SELECT employee_id, review_date, rating, 
    DENSE_RANK() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rnk 
    FROM performance_reviews
    WHERE employee_id IN (SELECT employee_id FROM fil1)
), fil3 AS (
    SELECT employee_id, review_date, rating, 
    LAG(rating, 1, 0) OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rat 
    FROM fil2 
    WHERE rnk <= 3
), fil4 AS (
    SELECT *, 
    COUNT(CASE WHEN rat = 0 OR rat > rating THEN 1 END)
    OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS cnt 
    FROM fil3
), fil5 AS (
    SELECT employee_id, 
    MAX(rating) - MIN(rating) AS performance_score, MAX(cnt) AS ch FROM fil4
    GROUP BY employee_id
    HAVING ch = 3
)
SELECT f.employee_id, name, performance_score AS improvement_score FROM fil5 f
JOIN employees p ON f.employee_id = p.employee_id
ORDER BY performance_score DESC, name ASC