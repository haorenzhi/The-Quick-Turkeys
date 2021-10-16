SELECT trr.area_name                             area_name,
       trr.trr_race_predominance                 trr_race_predominance,
       composition.composition_race_predominance composition_race_predominance,
       trr.trr_predominant_count                 trr_predominant_count,
       composition.composition_predominant_count composition_predominant_count
FROM (SELECT race_havecount.name       area_name,
             race_havecount.trr_race   trr_race_predominance,
             race_havecount.race_count trr_predominant_count
      FROM (SELECT name, trr_race, COUNT(trr_race) race_count
            FROM (
                     SELECT race_inarea.name, race_inarea.subject_race trr_race
                     FROM (
                              SELECT data_area.name,
                                     data_area.id,
                                     trr_trr.subject_race
                              FROM trr_trr,
                                   data_area
                              WHERE ST_CONTAINS(data_area.polygon, trr_trr.point)) race_inarea,
                          data_racepopulation
                     WHERE race_inarea.id = data_racepopulation.area_id) race_havedata
            GROUP BY name, trr_race) race_havecount,
           (SELECT name, MAX(race_count) race_predominant_count
            FROM (SELECT name, trr_race, COUNT(trr_race) race_count
                  FROM (
                           SELECT race_inarea.name, race_inarea.subject_race trr_race
                           FROM (
                                    SELECT data_area.name,
                                           data_area.id,
                                           trr_trr.subject_race
                                    FROM trr_trr,
                                         data_area
                                    WHERE ST_CONTAINS(data_area.polygon, trr_trr.point)) race_inarea,
                                data_racepopulation
                           WHERE race_inarea.id = data_racepopulation.area_id) race_havedata
                  GROUP BY name, trr_race) race_havecount
            GROUP BY name) race_predominance
      WHERE race_havecount.name = race_predominance.name
        AND race_havecount.race_count = race_predominance.race_predominant_count
      ORDER BY area_name) trr
         JOIN(
    SELECT race_havedata.area_name,
           race_havedata.composition_race composition_race_predominance,
           race_havedata.count            composition_predominant_count
    FROM (SELECT DISTINCT race_inarea.name         area_name,
                          data_racepopulation.race composition_race,
                          data_racepopulation.count
          FROM (
                   SELECT data_area.name,
                          data_area.id
                   FROM trr_trr,
                        data_area
                   WHERE ST_CONTAINS(data_area.polygon, trr_trr.point)) race_inarea,
               data_racepopulation
          WHERE race_inarea.id = data_racepopulation.area_id) race_havedata,
         (SELECT name area_name, MAX(count) race_predominant_count
          FROM (
                   SELECT DISTINCT race_inarea.name,
                                   data_racepopulation.race composition_race,
                                   data_racepopulation.count
                   FROM (
                            SELECT data_area.name,
                                   data_area.id
                            FROM trr_trr,
                                 data_area
                            WHERE ST_CONTAINS(data_area.polygon, trr_trr.point)) race_inarea,
                        data_racepopulation
                   WHERE race_inarea.id = data_racepopulation.area_id) race_havedata
          GROUP BY name) race_predominance
    WHERE race_havedata.area_name = race_predominance.area_name
      AND race_havedata.count = race_predominance.race_predominant_count
    ORDER BY area_name) composition
             ON (trr.area_name = composition.area_name)




