/*
  % of TRRs involving an officer firearm or taser depending on race?
 */

/*
 firearm
 */
select subject_race,
    count(*) as total_count,
    sum(case when number_of_officers_using_firearm > 0 then 1 else 0 end) as firearm_count,
    (sum(case when number_of_officers_using_firearm > 0 then 1 else 0 end) * 100.0 / count(*) )as firearm_percent
from trr_trr
where subject_race is not null
group by subject_race;

/*
 taser
 */
select subject_race,
    count(*) as total_count,
    sum(case when taser = 'true' then 1 else 0 end) as taser_count,
    (sum(case when taser = 'true' then 1 else 0 end) * 100.0 / count(*) )as taser_percent
from trr_trr
where subject_race is not null
group by subject_race;