# Write your MySQL query statement below
SELECT *, CASE WHEN SUBSTRING(dna_sequence, 1, 3) = 'ATG' THEN 1 ELSE 0 END AS has_start, CASE WHEN RIGHT(dna_sequence, 3) IN ('TAA', 'TAG', 'TGA') THEN 1 ELSE 0 END AS has_stop, CASE WHEN INSTR(dna_sequence, 'ATAT') > 0 THEN 1 ELSE 0 END AS has_atat, CASE WHEN INSTR(dna_sequence, 'GGG') > 0 THEN 1 ELSE 0 END AS has_ggg FROM samples
;