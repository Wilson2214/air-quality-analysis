{{
    config(
        materialized='view',
        schema='air_quality_dataset'
    )
}}

with source as (

    select 
        location,
        parse_datetime('%Y/%m/%d %H:%M:%S', datetime) as datetime,
        parameter,
        value
    from {{ source('staging', 'dallas') }}
    where value >= 0

),

renamed as (

    select
        location,
        "Dallas" as city,
        datetime,
        extract(HOUR FROM datetime) as hour_day,
        extract(MONTH FROM datetime) as month_val,
        parameter,
        value

    from source

)

select * from renamed