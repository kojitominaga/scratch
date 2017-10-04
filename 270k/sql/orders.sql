create table public.kt_orders (
       ebint integer not null primary key, 
       lastorder timestamp with time zone, 
       ts_completed timestamp with time zone)
