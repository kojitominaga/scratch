SELECT l.name, p.provider_name, l.eb_int, l.station_id, l.n_total, l.n_depths, l.n_dates, l.min_date, l.max_date, l.bath_NOSE as bathymetric_data 
from lakes as l, providers as p where l.provider_id = p.provider_id order by eb_int;
