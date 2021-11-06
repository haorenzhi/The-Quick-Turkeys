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
WHERE trr_trr_refresh_9.officer_unit_detail=data_policeunit.unit_name

ALTER TABLE trr_trr_refresh_9
DROP COLUMN officer_unit_name,
DROP COLUMN officer_unit_detail;