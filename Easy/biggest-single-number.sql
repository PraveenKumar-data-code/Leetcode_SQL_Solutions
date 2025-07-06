SELECT CASE 
  WHEN cnt = 1 THEN num
  ELSE null
  END AS num
 FROM (SELECT num, COUNT(num) AS cnt FROM MyNumbers
GROUP BY num
ORDER BY cnt, num DESC
) AS TAB2
LIMIT 1
# ON TAB1.num = TAB2.num
;