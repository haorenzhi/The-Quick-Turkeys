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

create temp table allcops as (
select race as officer_race,
       (count(data_officer.race) * 1.0),
       (select count(data_officer.race) from data_officer),
       ((count(data_officer.race) * 1.0) / (select count(data_officer.race) from data_officer)) as percentage
from data_officer
group by race);

create temp table chicago as (
select data_racepopulation.race as chicago_race,
       (sum(data_racepopulation.count) * 1.0 / (select sum(data_racepopulation.count) from data_racepopulation inner join data_area on data_racepopulation.area_id = data_area.id where data_area.area_type = 'community')) as percentage
from data_racepopulation inner join data_area on data_racepopulation.area_id = data_area.id
where data_area.area_type = 'community'
group by data_racepopulation.race);

select officer_race,
       chicago_race,
       chicago.percentage * allcops.percentage as probability
from chicago, allcops