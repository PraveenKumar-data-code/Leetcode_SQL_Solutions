SELECT TAB3.student_id, TAB3.student_name, TAB3.subject_name, COALESCE(TAB2.attended_exams, 0) AS attended_exams FROM 
(SELECT student_id, subject_name, student_name, COUNT(*) AS attended_exams FROM (SELECT E.student_id AS student_id, E.subject_name AS subject_name, S.student_name AS student_name FROM Examinations E
CROSS JOIN Students S
ON E.student_id = S.student_id
ORDER BY 1,2,3) AS TAB1
GROUP BY 1,2,3
ORDER BY 1,2,3) AS TAB2
RIGHT JOIN
(SELECT
    s.student_id AS student_id,
    s.student_name AS student_name,
    sub.subject_name AS subject_name
FROM Students s
CROSS JOIN Subjects sub
ORDER BY s.student_id, sub.subject_name) AS TAB3
ON TAB2.student_id = TAB3.student_id AND TAB2.student_name = TAB3.student_name AND
TAB2.subject_name = TAB3.subject_name
ORDER BY student_id, subject_name
;