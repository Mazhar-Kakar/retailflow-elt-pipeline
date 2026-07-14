{{ config(
    materialized='view',
    schema='staging',
) }}

WITH cleaned_customers AS (
    SELECT 
        CAST(customer_id AS INT) AS customer_id,
        TRIM(first_name) AS first_name,
        TRIM(last_name) AS last_name,
        CASE
            WHEN REGEXP_LIKE (LOWER(TRIM(email)), '^[a-z0-9._+%-]+@[a-z0-9.-]+\\.[a-z]{2,}$') THEN LOWER(TRIM(email))
            ELSE 'unknown'
        END AS email,
        TRIM(city) AS city,
        TRIM(province) AS province,
        TRIM(country) AS country,
        TO_TIMESTAMP_NTZ(created_timestamp) AS created_timestamp,
        TO_TIMESTAMP_NTZ(updated_timestamp) AS updated_timestamp,
        CASE 
            WHEN LOWER(TRIM(is_active)) = 'y' THEN TRUE
            ELSE FALSE 
        END AS is_active
    FROM {{ source('bronze', 'customers') }}
)
SELECT
    *
FROM cleaned_customers