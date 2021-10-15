/*
  % of TRRs involving an officer firearm depending on race?

 */

select subject_race,
    count(*) as total_count,
    sum(case when number_of_officers_using_firearm > 0 then 1 else 0 end) as firearm_count,
    (sum(case when number_of_officers_using_firearm > 0 then 1 else 0 end) * 100.0 / count(*) )as firearm_percent
from trr_trr
group by subject_race;

/*
 where number_of_officers_using_firearm > 0
 */