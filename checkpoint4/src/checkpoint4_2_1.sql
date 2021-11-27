CREATE TEMP TABLE officer_trr AS
(SELECT officer_id, COUNT(*)
FROM trr_trr
WHERE officer_id IS NOT NULL
GROUP BY officer_id);

CREATE TEMP TABLE officer_beat AS
(SELECT officer_assigned_beat, officer_id
FROM trr_trr
WHERE officer_assigned_beat IS NOT NULL
AND  officer_id IS NOT NULL
ORDER BY officer_assigned_beat,officer_id);

\copy officer_trr TO 'officer_trr.txt'
\copy officer_beat TO 'officer_beat.txt'