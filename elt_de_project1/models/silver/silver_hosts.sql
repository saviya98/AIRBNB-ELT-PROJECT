{{
    config(materialized='incremental', unique_key='host_id')
}}

SELECT 
    host_id,
    REPLACE(host_name, ' ', '_') AS host_name,
    host_since,
    is_superhost,
    response_rate,
    CASE
        WHEN response_rate > 95 THEN 'EXCELLENT'
        WHEN response_rate > 80 THEN 'GOOD'
        WHEN response_rate > 60 THEN 'AVERAGE'
        ELSE 'POOR'
    END AS response_rate_quality,
    created_at
FROM {{ ref("bronze_hosts")}}