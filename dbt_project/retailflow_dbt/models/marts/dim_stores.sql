{{
  config(
    materialized = 'table',
    schema = 'dim'
    )
}}

WITH dim_store AS (
    SELECT 
        store_id,
        store_name,
        city,
        province,
        created_timestamp,
        is_active
    FROM {{ ref('stg_stores') }}
)

SELECT * 
FROM dim_store