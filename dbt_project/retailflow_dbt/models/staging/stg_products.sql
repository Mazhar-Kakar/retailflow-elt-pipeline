{{
  config(
    materialized = 'view',
    schema = 'staging'
    )
}}

WITH source_data AS (
    SELECT *
    FROM {{ source('bronze', 'products') }}
),

cleaned_data AS (
    
    SELECT 
        product_id,
        LOWER(TRIM(product_name)) AS product_name,
        LOWER(TRIM(category)) AS category,
        LOWER(TRIM(brand)) AS brand,
        CAST(price AS DECIMAL(16, 2)) AS price,
        created_timestamp,
        updated_timestamp,
        {{clean_is_active('is_active')}} AS is_active
    FROM source_data
)

SELECT *
FROM cleaned_data
