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
    from {{ source('staging', 'riverside') }}
    where value >= 0

),

renamed as (

    select
        location,
        "Riverside" as city,
        datetime,
        extract(HOUR FROM datetime) as hour_day,
        parameter,
        value

    from source

)

select * from renamed