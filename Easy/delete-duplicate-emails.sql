# Write your MySQL query statement below
delete P1 from person P1, person P2 
where P1.email=P2.email and P1.id>P2.id;
;