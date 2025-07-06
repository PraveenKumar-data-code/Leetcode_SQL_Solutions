WITH RECURSIVE 
cte AS (
  SELECT *, LENGTH(content_text) - LENGTH(REPLACE(content_text, ' ', '')) AS leng FROM user_content
),
cte2 AS (
  SELECT MAX(leng) AS max_length FROM cte
),
cte3 AS (
  SELECT 1 AS level
  UNION ALL
  SELECT level + 1 FROM cte3, cte2
  WHERE level <= cte2.max_length
), cte4 AS (
  SELECT content_id, content_text, level FROM cte
  JOIN cte3 ON cte.leng >= cte3.level - 1
  ORDER BY content_id, level
), cte5 AS (
  SELECT content_id, content_text, CONCAT( 
  UPPER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(content_text, ' ', level), ' ', -1), 1, 1)),
  LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(content_text, ' ', level), ' ', -1), 2))) AS word, level FROM cte4
), cte6 AS (
  SELECT content_id, content_text, IF(LENGTH(word) - LENGTH(REPLACE(word, '-', '')) = 1, 
  CONCAT(
      CONCAT(
          UPPER(SUBSTRING(SUBSTRING_INDEX(word, '-', 1), 1, 1)), 
          LOWER(SUBSTRING(SUBSTRING_INDEX(word, '-', 1), 2))), 
      '-', 
      CONCAT(
          UPPER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(word, '-', 2), '-', -1), 1, 1)), 
          LOWER(SUBSTRING(SUBSTRING_INDEX(SUBSTRING_INDEX(word, '-', 2), '-', -1), 2)))) , word) AS word, 
  level FROM cte5
)

SELECT content_id, content_text AS original_text, GROUP_CONCAT(word ORDER BY level SEPARATOR ' ') AS converted_text FROM cte6
GROUP BY content_id
;