# Write your MySQL query statement below
WITH a AS (
SELECT patient_id, COUNT(CASE WHEN result = "Positive" THEN 1 END) AS pos_cnt, COUNT(CASE WHEN result = "Negative" THEN 1 END) AS neg_cnt FROM covid_tests
GROUP BY patient_id), b AS (
SELECT patient_id, CASE WHEN pos_cnt > 0 AND neg_cnt > 0 THEN 1 ELSE 0 END AS cnt FROM a
), c AS (
SELECT patient_id, MIN(CASE WHEN result = "Positive" THEN test_date END) AS min_pos_date FROM covid_tests
WHERE patient_id IN (SELECT patient_id FROM b WHERE cnt > 0)
GROUP BY patient_id
), d AS (
SELECT c.patient_id, COALESCE(MIN(CASE WHEN result = "Negative" AND test_date > min_pos_date THEN test_date END), 0) AS min_neg_date FROM covid_tests t
JOIN c ON c.patient_id = t.patient_id
GROUP BY c.patient_id
)
SELECT d.patient_id, patient_name, age, DATEDIFF(min_neg_date, min_pos_date) AS recovery_time FROM d
JOIN c ON c.patient_id = d.patient_id
JOIN patients p ON p.patient_id = d.patient_id
WHERE min_neg_date != 0
ORDER BY recovery_time ASC, patient_name ASC
;