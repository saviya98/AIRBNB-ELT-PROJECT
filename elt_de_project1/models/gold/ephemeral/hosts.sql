-- Intentionally ephemeral: this model only exists to feed
-- snapshots/dim_hosts.yml (relation: ref('hosts')). It is never materialized
-- as its own table/view -- dbt inlines it as a CTE wherever it's ref()'d.
-- The physical, queryable dimension is GOLD.DIM_HOSTS (the snapshot
-- output), not this model. Query that instead.
{{ config(
    materialized='ephemeral'
) }}

WITH hosts AS (
    SELECT 
        host_id,
        host_name,
        host_since,
        is_superhost,
        response_rate_quality,
        host_created_at
    FROM {{ ref('obt')}}
)
SELECT * FROM hosts