# Write your MySQL query statement below
with a as (
SELECT book_id, COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS cnt FROM borrowing_records
GROUP BY book_id
)
select l.book_id, title, author, genre, publication_year, total_copies AS current_borrowers from library_books l
join a on l.book_id = a.book_id
WHERE cnt = total_copies
ORDER BY current_borrowers DESC, title ASC
;