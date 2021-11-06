ALTER TABLE trr_trr_refresh_9
ADD PRIMARY KEY (id);

ALTER TABLE trr_trr_refresh_9
RENAME cr_number TO crid;

ALTER TABLE trr_trr_refresh_9
RENAME event_number TO event_id;

CREATE TABLE data_officer_9
AS TABLE data_officer;

ALTER TABLE data_officer_9
ADD PRIMARY KEY(id);

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
RENAME trr_report_id TO trr_id;

ALTER TABLE trr_charge_refresh_9
RENAME trr_report_id TO trr_id;

ALTER TABLE trr_charge_refresh_9
DROP COLUMN trr_rd_no;

ALTER TABLE trr_weapondischarge_refresh_9
RENAME trr_report_id TO trr_id;

ALTER TABLE trr_trrstatus_refresh_9
RENAME officer_rank TO rank;

ALTER TABLE trr_trrstatus_refresh_9
RENAME officer_star TO star;

ALTER TABLE trr_trrstatus_refresh_9
RENAME trr_report_id TO trr_id;

ALTER TABLE trr_trrstatus_refresh_9
DROP COLUMN officer_age,
DROP COLUMN officer_unit_at_incident;

ALTER TABLE trr_subjectweapon_refresh_9
RENAME trr_report_id TO trr_id;