# Write your MySQL query statement below
SELECT machine_id, ROUND((avg/cnt), 3) AS processing_time FROM (SELECT machine_id, COUNT(*) AS cnt, SUM(avg) AS avg FROM (SELECT machine_id, process_id, ROUND((end1-start), 3) AS avg FROM (
  SELECT machine_id, process_id, SUM(ROUND(start, 3)) AS start, SUM(ROUND(end1, 3)) AS end1 FROM (SELECT machine_id, process_id, CASE activity_type
 WHEN 'start' THEN timestamp 
 ELSE 0
 END AS start, CASE activity_type
 WHEN 'end' THEN timestamp
 ELSE 0
 END AS end1 FROM Activity) AS SUB
 GROUP BY machine_id, process_id
 ) AS TAB) AS TAB1
 GROUP BY machine_id) AS TAB2
 ;