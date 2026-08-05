-- Intentionally ephemeral: this model only exists to feed
-- snapshots/dim_bookings.yml (relation: ref('bookings')). It is never
-- materialized as its own table/view -- dbt inlines it as a CTE wherever
-- it's ref()'d.
{{ config(
    materialized='ephemeral'
) }}

WITH bookings AS (
    SELECT 
        booking_id,
        booking_date,
        booking_status,
        created_at
    FROM {{ ref('obt')}}
)
SELECT * FROM bookings