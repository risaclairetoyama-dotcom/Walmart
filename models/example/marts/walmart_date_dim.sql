{{ config(
    materialized='incremental',
    unique_key='date_id'
) }}

with raw_dates as (
    select distinct 
        Date as store_date,
        IsHoliday as isholiday
    from {{ source('raw_walmart', 'RAW_DEPARTMENT') }}
)

select
    row_number() over (order by store_date) as date_id,
    store_date,
    isholiday,
    current_timestamp() as insert_date,
    current_timestamp() as update_date
from raw_dates