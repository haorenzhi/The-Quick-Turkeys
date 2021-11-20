\set ON_ERROR_STOP on

DROP TABLE IF EXISTS  trr_trr_refresh_9;
CREATE TEMP TABLE  trr_trr_refresh_9(
    id                       integer,
    event_number             varchar,
    cr_number                text,
    beat                     int,
    block                    varchar(8),
    direction                varchar(8),
    street                   varchar(64),
    location                 varchar(64),
    trr_datetime             timestamp,
    indoor_or_outdoor        varchar(8),
    lighting_condition       varchar(32),
    weather_condition        varchar(32),
    notify_oemc              bool,
    notify_district_sergeant bool,
    notify_op_command        bool,
    notify_det_division      bool,
    party_fired_first        varchar(16),
    officer_assigned_beat    varchar(16),
    officer_on_duty          bool,
    officer_in_uniform       bool,
    officer_injured          bool,
    officer_rank             varchar(45),
    subject_armed            bool,
    subject_injured          bool,
    subject_alleged_injury   bool,
    subject_age              int,
    subject_birth_year       int,
    subject_gender           varchar(6),
    subject_race             varchar(32),
    officer_last_name        text,
    officer_suffix_name      text,
    officer_first_name       text,
    officer_middle_initial   text,
    officer_gender           text,
    officer_race             text,
    officer_age              int,
    officer_appointed_date   date,
    officer_birth_year       int,
    officer_unit_name        varchar,
    officer_unit_detail      varchar,
    trr_created              timestamp,
    latitude                 numeric,
    longitude                numeric,
    point                    geometry(Point, 4326)
);

DROP TABLE IF EXISTS  trr_trrstatus_refresh_9;
CREATE TEMP TABLE  trr_trrstatus_refresh_9(
    officer_rank             varchar,
    officer_star             varchar,
    status                   varchar(16),
    status_datetime          timestamp,
    officer_age              smallint,
    officer_first_name       varchar,
    officer_middle_initial   varchar(8),
    officer_last_name        varchar,
    officer_suffix_name      varchar,
    officer_gender           varchar,
    officer_race             varchar,
    officer_birth_year       int,
    officer_appointed_date   date,
    officer_unit_at_incident varchar,
    trr_report_id            integer
);

DROP TABLE IF EXISTS  trr_subjectweapon_refresh_9;
CREATE TEMP TABLE  trr_subjectweapon_refresh_9(
    weapon_type        varchar(64),
    firearm_caliber    varchar,
    weapon_description varchar(64),
    trr_report_id      integer
);

DROP TABLE IF EXISTS  trr_weapondischarge_refresh_9;
CREATE TEMP TABLE  trr_weapondischarge_refresh_9(
    weapon_type                  varchar(32),
    weapon_type_description      varchar,
    firearm_make                 varchar(64),
    firearm_model                varchar(32),
    firearm_barrel_length        varchar,
    firearm_caliber              varchar,
    total_number_of_shots        smallint,
    firearm_reloaded             bool,
    number_of_cartridge_reloaded smallint,
    handgun_worn_type            varchar(32),
    handgun_drawn_type           varchar(32),
    method_used_to_reload        varchar(64),
    sight_used                   bool,
    protective_cover_used        varchar,
    discharge_distance           varchar(16),
    object_struck_of_discharge   varchar(32),
    discharge_position           varchar(32),
    trr_report_id                integer
);

DROP TABLE IF EXISTS  trr_actionresponse_refresh_9;
CREATE TEMP TABLE  trr_actionresponse_refresh_9 AS SELECT * FROM trr_actionresponse_refresh;

DROP TABLE IF EXISTS  trr_charge_refresh_9;
CREATE TEMP TABLE  trr_charge_refresh_9 AS SELECT * FROM trr_charge_refresh;

\copy trr_trr_refresh_9 FROM 'temp/trr_trr_refresh.csv' CSV HEADER
\copy trr_trrstatus_refresh_9 FROM 'temp/trr_trrstatus_refresh.csv' CSV HEADER
\copy trr_subjectweapon_refresh_9 FROM 'temp/trr_subjectweapon_refresh.csv' CSV HEADER
\copy trr_weapondischarge_refresh_9 FROM 'temp/trr_weapondischarge_refresh.csv' CSV HEADER

-- 1

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
+ CASE WHEN a.officer_appointed_date=b.appointed_date
OR a.officer_appointed_date IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_birth_year=b.birth_year
OR a.officer_birth_year IS NULL THEN 1 ELSE 0 END) >6;

--2
ALTER TABLE trr_trr_refresh_9
DROP COLUMN officer_first_name,
DROP COLUMN officer_middle_initial,
DROP COLUMN officer_last_name,
DROP COLUMN officer_suffix_name,
DROP COLUMN officer_gender,
DROP COLUMN officer_race,
DROP COLUMN officer_appointed_date,
DROP COLUMN officer_birth_year;

ALTER TABLE trr_trrstatus_refresh_9
ADD officer_id INT;

/*
UPDATE trr_trrstatus_refresh_9 a
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
+ CASE WHEN a.officer_appointed_date=b.appointed_date
OR a.officer_appointed_date IS NULL THEN 1 ELSE 0 END
+ CASE WHEN a.officer_birth_year=b.birth_year
OR a.officer_birth_year IS NULL THEN 1 ELSE 0 END) >6;
*/
ALTER TABLE trr_trrstatus_refresh_9
DROP COLUMN officer_first_name,
DROP COLUMN officer_middle_initial,
DROP COLUMN officer_last_name,
DROP COLUMN officer_suffix_name,
DROP COLUMN officer_gender,
DROP COLUMN officer_race,
DROP COLUMN officer_appointed_date,
DROP COLUMN officer_birth_year;
--3
UPDATE trr_trr_refresh_9
SET officer_unit_name=RIGHT(concat('000', trr_trr_refresh_9.officer_unit_name),3)
WHERE officer_unit_name IS NOT NULL;

UPDATE trr_trr_refresh_9
SET officer_unit_detail=RIGHT(concat('000', trr_trr_refresh_9.officer_unit_detail),3)
WHERE officer_unit_detail IS NOT NULL;

ALTER TABLE trr_trr_refresh_9
ADD officer_unit_id INT,
ADD officer_unit_detail_id INT;

UPDATE trr_trr_refresh_9
SET officer_unit_id=data_policeunit.id
FROM data_policeunit
WHERE trr_trr_refresh_9.officer_unit_name=data_policeunit.unit_name;

UPDATE trr_trr_refresh_9
SET officer_unit_detail_id=data_policeunit.id
FROM data_policeunit
WHERE trr_trr_refresh_9.officer_unit_detail=data_policeunit.unit_name;

ALTER TABLE trr_trr_refresh_9
DROP COLUMN officer_unit_name,
DROP COLUMN officer_unit_detail;

--4
CREATE TEMP TABLE data_policeunit_9
AS TABLE data_policeunit;

ALTER TABLE data_policeunit_9
ADD PRIMARY KEY(id);

ALTER TABLE trr_trr_refresh_9
ADD FOREIGN KEY (officer_unit_id)
REFERENCES data_policeunit_9(id);

ALTER TABLE trr_trr_refresh_9
ADD FOREIGN KEY (officer_unit_detail_id)
REFERENCES data_policeunit_9(id);
--5
/*
CREATE TABLE trr_actionresponse_refresh_9
AS TABLE trr_actionresponse_refresh;

CREATE TABLE trr_charge_refresh_9
AS TABLE trr_charge_refresh;
 */
--6
DELETE FROM trr_actionresponse_refresh_9
WHERE trr_report_id NOT IN (SELECT id FROM trr_trr_refresh);

DELETE FROM trr_charge_refresh_9
WHERE trr_report_id NOT IN (SELECT id FROM trr_trr_refresh);

DELETE FROM trr_subjectweapon_refresh_9
WHERE trr_report_id NOT IN (SELECT id FROM trr_trr_refresh);

DELETE FROM trr_weapondischarge_refresh_9
WHERE trr_report_id NOT IN (SELECT id FROM trr_trr_refresh);

DELETE FROM trr_trrstatus_refresh_9
WHERE trr_report_id NOT IN (SELECT id FROM trr_trr_refresh);
--7
ALTER TABLE trr_trr_refresh_9
ADD CONSTRAINT trr_trrPrimaryKey PRIMARY KEY (id);

ALTER TABLE trr_trr_refresh_9
RENAME COLUMN cr_number TO crid;

ALTER TABLE trr_trr_refresh_9
RENAME COLUMN event_number TO event_id;

CREATE TEMP TABLE data_officer_9
AS TABLE data_officer;

ALTER TABLE data_officer_9
ADD CONSTRAINT data_officerPrimaryKey PRIMARY KEY(id);

ALTER TABLE trr_trr_refresh_9
ADD FOREIGN KEY (officer_id)
REFERENCES data_officer_9(id);

ALTER TABLE trr_actionresponse_refresh_9
ADD FOREIGN KEY (trr_report_id)
REFERENCES trr_trr_refresh_9(id);

ALTER TABLE trr_charge_refresh_9
ADD FOREIGN KEY (trr_report_id)
REFERENCES trr_trr_refresh_9(id);

ALTER TABLE trr_weapondischarge_refresh_9
ADD FOREIGN KEY (trr_report_id)
REFERENCES trr_trr_refresh_9(id);

ALTER TABLE trr_trrstatus_refresh_9
ADD FOREIGN KEY (trr_report_id) REFERENCES trr_trr_refresh_9(id),
ADD FOREIGN KEY (officer_id) REFERENCES data_officer_9(id);

ALTER TABLE trr_subjectweapon_refresh_9
ADD FOREIGN KEY (trr_report_id)
REFERENCES trr_trr_refresh_9(id);

ALTER TABLE trr_trr_refresh_9
DROP COLUMN officer_age,
DROP COLUMN trr_created,
DROP COLUMN latitude,
DROP COLUMN longitude;

ALTER TABLE trr_actionresponse_refresh_9
RENAME COLUMN trr_report_id TO trr_id;

ALTER TABLE trr_charge_refresh_9
RENAME COLUMN trr_report_id TO trr_id;

ALTER TABLE trr_charge_refresh_9
DROP COLUMN trr_rd_no;

ALTER TABLE trr_weapondischarge_refresh_9
RENAME COLUMN trr_report_id TO trr_id;

ALTER TABLE trr_trrstatus_refresh_9
RENAME COLUMN officer_rank TO rank;

ALTER TABLE trr_trrstatus_refresh_9
RENAME COLUMN officer_star TO star;

ALTER TABLE trr_trrstatus_refresh_9
RENAME COLUMN trr_report_id TO trr_id;

ALTER TABLE trr_trrstatus_refresh_9
DROP COLUMN officer_age,
DROP COLUMN officer_unit_at_incident;

ALTER TABLE trr_subjectweapon_refresh_9
RENAME COLUMN trr_report_id TO trr_id;



\copy trr_trr_refresh_9 TO '../output/trr-trr.csv' CSV HEADER
\copy trr_trrstatus_refresh_9 TO '../output/trr-trrstatus.csv' CSV HEADER
\copy trr_subjectweapon_refresh_9 TO '../output/trr-subjectweapon.csv' CSV HEADER
\copy trr_weapondischarge_refresh_9 TO '../output/trr-weapondischarge.csv' CSV HEADER
\copy trr_actionresponse_refresh_9 TO '../output/trr-actionresponse.csv' CSV HEADER
\copy trr_charge_refresh_9 TO '../output/trr-charge.csv' CSV HEADER

\set ON_ERROR_STOP off
