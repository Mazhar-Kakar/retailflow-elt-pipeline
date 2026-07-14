{{
  config(
    materialized = 'view',
    schema = 'staging'
    )
}}

WITH source_data AS (
    SELECT *
    FROM {{ source('bronze', 'stores') }}
),

cleaned_data AS (
    SELECT
        store_id,
        LOWER(TRIM(store_name)) AS store_name,
        LOWER(TRIM(city)) AS city,
        LOWER(TRIM(province)) AS province,
        LOWER(TRIM(country)) AS country,
        created_timestamp,
        updated_timestamp,
        {{clean_is_active('is_active')}} AS is_active
    FROM source_data
)

SELECT *
FROM cleaned_data


