# Write your MySQL query statement below
SELECT ROUND(ans / denom, 2) AS fraction
FROM (
    SELECT COALESCE(COUNT(*), 0) AS ans,
           (SELECT COUNT(DISTINCT player_id) FROM Activity) AS denom
    FROM (
        SELECT player_id, SUM(DATEDIFF(event_date, sec)) AS cnt
        FROM (
            SELECT player_id, event_date, LAG(event_date, 1, event_date) OVER(PARTITION BY player_id ORDER BY player_id, event_date) AS sec
            FROM (
                SELECT player_id, event_date, ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY player_id, event_date) AS row_num
                FROM Activity
                WHERE player_id IN (
                    SELECT player_id
                    FROM (
                        SELECT player_id, COUNT(*) AS cnt
                        FROM Activity
                        GROUP BY player_id
                    ) AS s
                    WHERE cnt >= 2
                )
                ORDER BY player_id, event_date
            ) AS v
            WHERE row_num <= 2
        ) AS v
        GROUP BY player_id
    ) AS j
    WHERE cnt <= 1 and cnt != 0
) AS u;