SELECT DISTINCT email FROM Person
WHERE email IN
(SELECT df.email FROM (SELECT email,COUNT(email) AS cnt FROM Person
GROUP BY email
) df
WHERE df.cnt > 1);