{{ config(materialized='table') }}

with obt as (
    select * from {{ ref('obt') }}
),

dim_listings as (
    select * from {{ ref('dim_listings') }}
),

dim_hosts as (
    select * from {{ ref('dim_hosts') }}
)

select
    obt.booking_id,
    obt.listing_id,
    obt.host_id,
    dim_listings.dbt_scd_id as listing_scd_id,
    dim_hosts.dbt_scd_id as host_scd_id,
    obt.total_amount,
    obt.service_fee,
    obt.cleaning_fee,
    obt.accommodates,
    obt.bathrooms,
    obt.bedrooms,
    obt.price_per_night,
    obt.response_rate
from obt
left join dim_listings
    on obt.listing_id = dim_listings.listing_id
    and obt.booking_date >= dim_listings.dbt_valid_from
    and (obt.booking_date < dim_listings.dbt_valid_to or dim_listings.dbt_valid_to is null)
left join dim_hosts
    on obt.host_id = dim_hosts.host_id
    and obt.booking_date >= dim_hosts.dbt_valid_from
    and (obt.booking_date < dim_hosts.dbt_valid_to or dim_hosts.dbt_valid_to is null)
