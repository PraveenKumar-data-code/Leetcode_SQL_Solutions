WITH cte AS (
SELECT student_id, subject, MIN(exam_date) AS min_date, MAX(exam_date) AS max_date FROM scores
GROUP BY student_id, subject
)
SELECT s.student_id, s.subject, SUM(CASE WHEN exam_date = min_date THEN score END) AS first_score, 
SUM(CASE WHEN exam_date = max_date THEN score END) AS latest_score FROM scores s
JOIN cte ON cte.student_id = s.student_id AND cte.subject = s.subject
GROUP BY s.student_id, s.subject
HAVING first_score < latest_score
ORDER BY s.student_id, s.subject
;