{{
    config(
        materialized='table',
        schema='air_quality_dataset'
    )
}}

with combined_hourly as (
    select *
    from {{ ref('combined_hourly') }}
)

select city, rush_hour, month_val, avg(value) as avg_pm25
from combined_hourly
group by city, rush_hour, month_val