{{
  config(
    materialized = 'table',
    schema = 'dim'
    )
}}

WITH dim_products AS (
    SELECT
        product_id,
        product_name,
        category,
        brand,
        price,
        created_timestamp,
        is_active
    FROM {{ ref('stg_products') }}
)

SELECT *
FROM dim_products