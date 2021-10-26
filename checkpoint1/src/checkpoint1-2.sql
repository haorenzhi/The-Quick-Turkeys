/*
 Is there an increased likelihood of a TRR between the race of the officer and race of the subject?
 */

select race as officer_race,
       subject_race,
       count(*) as trr_count,
       count(*) * 100.0 / (select count(*) from trr_trr where subject_race is not null) as trr_percentage
from trr_trr
inner join data_officer on data_officer.id = trr_trr.officer_id
where subject_race is not null
group by race, subject_race;