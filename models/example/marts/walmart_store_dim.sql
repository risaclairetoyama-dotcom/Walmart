{{ config(
    materialized='incremental',
    unique_key=['store_id', 'dept_id']
) }}

with raw_combos as (
    select distinct
        d.Store as store_id,
        d.Dept as dept_id,
        s.Type as store_type,
        s.Size as store_size
    from {{ source('raw_walmart', 'RAW_DEPARTMENT') }} d
    left join {{ source('raw_walmart', 'RAW_STORES') }} s
        on d.Store = s.Store
)

select
    store_id,
    dept_id,
    store_type,
    store_size,
    current_timestamp() as insert_date,
    current_timestamp() as update_date
from raw_combos