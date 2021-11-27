create temp table events as
(select officer_id, id, event_id
from trr_trr
where event_id in (select event_id
                    from trr_trr
                    group by event_id
                    having count(event_id) > 1)
order by event_id ASC);

create temp table officer_trr as
(select officer_id, count(*)
from trr_trr
where officer_id is not null
group by officer_id);

\copy events to 'events.csv'
\copy officer_trr to 'officer_trr.txt'