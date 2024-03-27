{{
    config(
        materialized='table',
        schema='air_quality_dataset'
    )
}}

select 
    location_val,
    location,
    transit_rank,
    transit_user_share
from {{ ref('transit_ridership') }}