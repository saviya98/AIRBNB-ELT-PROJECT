-- Intentionally ephemeral: this model only exists to feed
-- snapshots/dim_listings.yml (relation: ref('listings')). It is never
-- materialized as its own table/view -- dbt inlines it as a CTE wherever
-- it's ref()'d. The physical, queryable dimension is GOLD.DIM_LISTINGS
-- (the snapshot output), not this model. Query that instead.
{{ config(
    materialized='ephemeral'
) }}

WITH listings AS (
    SELECT 
        listing_id,
        property_type,
        room_type,
        city,
        country,
        price_per_night_tag,
        listing_created_at
    FROM {{ ref('obt')}}
)
SELECT * FROM listings