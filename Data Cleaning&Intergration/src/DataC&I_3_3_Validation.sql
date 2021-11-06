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