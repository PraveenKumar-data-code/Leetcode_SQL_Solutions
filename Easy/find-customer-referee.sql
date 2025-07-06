SELECT name FROM customer
WHERE COALESCE(referee_id, 0) <> 2
;