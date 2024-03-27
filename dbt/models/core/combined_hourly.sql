{{
    config(
        materialized='table',
        schema='air_quality_dataset'
    )
}}

with dallas_data as (
    select *
    from {{ ref('stg_dallas') }}
),
dc_data as (
    select *
    from {{ ref('stg_dc') }}
),
nynj_data as (
    select *
    from {{ ref('stg_nynj') }}
),
riverside_data as (
    select *
    from {{ ref('stg_riverside') }}
),
hourly_aq_unioned as (
    select * from dallas_data
    union all
    select * from dc_data
    union all
    select * from nynj_data
    union all
    select * from riverside_data
)

select * from hourly_aq_unioned