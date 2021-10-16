select count(data_allegation.most_common_category_id)
from data_allegation,data_allegationcategory
as number_of_force_allegation
where data_allegation.most_common_category_id=data_allegationcategory.id
AND data_allegationcategory.category='Use Of Force'

select count(*)
as number_of_trr
from trr_trr








