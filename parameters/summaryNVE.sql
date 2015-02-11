SELECT l.name, p.provider_name, l.n_total, 
l.n_depths, l.n_dates, l.n_years_summer, l.min_date, l.max_date, l.min_year_summer, l.max_year_summer, 
l.bath_NOSE as bathymetric_data 
from lakes as l, providers as p 
where l.provider_id = p.provider_id and l.provider_id = 6 and l.n_depths > 15 
order by l.n_years_summer desc;
