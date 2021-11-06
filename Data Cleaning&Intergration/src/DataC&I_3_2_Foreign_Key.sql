CREATE TABLE data_policeunit_9
AS TABLE data_policeunit;

ALTER TABLE data_policeunit_9
ADD PRIMARY KEY(id);

ALTER TABLE trr_trr_refresh_9
ADD FOREIGN KEY (officer_unit_id)
REFERENCES data_policeunit_9(id);

ALTER TABLE trr_trr_refresh_9
ADD FOREIGN KEY (officer_unit_detail_id)
REFERENCES data_policeunit_9(id);