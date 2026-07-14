{{ config(
    materialized='view',
    schema='staging'
) }}

WITH source_data AS (
    SELECT *
    FROM {{ source('bronze', 'customers') }}
),
cleaned_data AS (
    SELECT 
        customer_id,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        CASE
            WHEN REGEXP_LIKE (LOWER(TRIM(email)), '^[a-z0-9._+%-]+@[a-z0-9.-]+\\.[a-z]{2,}$') THEN LOWER(TRIM(email))
            ELSE 'unknown'
        END AS email,
        TRIM(city) AS city,
        TRIM(province) AS province,
        TRIM(country) AS country,
        created_timestamp,
        updated_timestamp,
        {{clean_is_active('is_active')}} AS is_active
    FROM source_data
)

SELECT *
FROM cleaned_data