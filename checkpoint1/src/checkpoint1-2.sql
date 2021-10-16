/*
 Is there an increased likelihood of a TRR between the race of the officer and race of the subject?
 */

select race from data_officer INNER JOIN trr_trr ON trr_trr.officer_id = data_officer.id
