select count(data_allegation.most_common_category_id)
as number_of_force_allegation
from data_allegation,data_allegationcategory
where data_allegation.most_common_category_id=data_allegationcategory.id
AND data_allegationcategory.category='Use Of Force'

select count(*)
as number_of_trr
from trr_trr

