{{ config(
    materialized='incremental',
    unique_key=['store_id', 'dept_id', 'date_id', 'vrsn_start_date']
) }}

with dept_sales as (
    select 
        Store as store_id,
        Dept as dept_id,
        Date as store_date,
        Weekly_Sales as store_weekly_sales
    from {{ source('raw_walmart', 'RAW_DEPARTMENT') }}
),

fact_metrics as (
    select 
        Store as store_id,
        Date as store_date,
        Temperature as store_temperature,
        Fuel_Price as fuel_price,
        Markdown1,
        Markdown2,
        Markdown3,
        Markdown4,
        Markdown5,
        CPI,
        Unemployment as unemployement
    from {{ source('raw_walmart', 'RAW_FACT') }}
),

dates as (
    select date_id, store_date from {{ ref('walmart_date_dim') }}
)

select
    ds.store_id,
    ds.dept_id,
    d.date_id,
    fm.store_temperature,
    fm.fuel_price,
    fm.unemployement,
    fm.cpi,
    fm.markdown1,
    fm.markdown2,
    fm.markdown3,
    fm.markdown4,
    fm.markdown5,
    ds.store_weekly_sales,
    ds.store_date as vrsn_start_date,
    coalesce(
        lead(ds.store_date) over (partition by ds.store_id, ds.dept_id order by ds.store_date),
        '9999-12-31'::date
    ) as vrsn_end_date,
    current_timestamp() as insert_date,
    current_timestamp() as update_date
from dept_sales ds
join fact_metrics fm 
    on ds.store_id = fm.store_id 
   and ds.store_date = fm.store_date
join dates d 
    on ds.store_date = d.store_date