ALTER TABLE trr_trr_refresh_9
ADD officer_id INT;

UPDATE trr_trr_refresh_9 a
SET officer_id=b.id
FROM data_officer b
WHERE (CASE WHEN a.officer_last_name=b.last_name
OR a.officer_last_name IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_first_name=b.first_name
OR a.officer_first_name IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_suffix_name=b.suffix_name
OR a.officer_suffix_name IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_middle_initial=b.middle_initial
OR a.officer_middle_initial IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_gender=b.gender
OR a.officer_gender IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_race=b.race
OR a.officer_race IS NULL THEN 1 ELSE 0 END
+ CASE WHEN to_date(a.officer_appointed_date,'yyyy-MM-dd')=b.appointed_date
OR a.officer_appointed_date IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_birth_year=b.birth_year
OR a.officer_birth_year IS NULL THEN 1 ELSE 0 END) >6;

ALTER TABLE trr_trr_refresh_9
DROP COLUMN officer_first_name,
DROP COLUMN officer_middle_initial,
DROP COLUMN officer_last_name,
DROP COLUMN officer_suffix_name,
DROP COLUMN officer_gender,
DROP COLUMN officer_race,
DROP COLUMN officer_appointed_date,
DROP COLUMN officer_birth_year;