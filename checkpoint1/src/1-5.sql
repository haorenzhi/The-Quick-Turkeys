select data_officer.race,
count(*) as number_of_trr,
round( count(*) * 1.00/(select count(*) from trr_trr) ,4) as proportion
from trr_trr, data_officer
where trr_trr.officer_id=data_officer.id
group by data_officer.race

select data_officer.race,
count(*) as number_of_officer,
round( count(*) * 1.00/(select count(*) from data_officer) ,4) as proportion
from data_officer
group by data_officer.race

select data_officer.gender,
count(*) as number_of_trr,
round( count(*) * 1.00/(select count(*) from trr_trr) ,4) as proportion
from trr_trr, data_officer
where trr_trr.officer_id=data_officer.id
group by data_officer.gender

select data_officer.gender,
count(*) as number_of_officer,
round( count(*) * 1.00/(select count(*) from data_officer) ,4) as proportion
from data_officer
group by data_officer.gender

select data_officer.rank,
count(*) as number_of_trr,
round( count(*) * 1.00/(select count(*) from trr_trr) ,4) as proportion
from trr_trr, data_officer
where trr_trr.officer_id=data_officer.id
group by data_officer.rank
order by count(*) DESC

select data_officer.rank,
count(*) as number_of_officer,
round( count(*) * 1.00/(select count(*) from data_officer) ,4) as proportion
from data_officer
group by data_officer.rank
order by count(*) DESC







