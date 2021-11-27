CREATE TEMP TABLE officer_beat_refine
(officer1 integer,
officer2 integer);

\copy officer_beat_refine FROM 'officer_beat_refine.txt'

CREATE TEMP TABLE officer_beat_distinct AS
(SELECT DISTINCT officer1, officer2
FROM officer_beat_refine);

\copy officer_beat_distinct TO 'officer_beat_distinct.txt'