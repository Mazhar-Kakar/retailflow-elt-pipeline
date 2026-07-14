{{
  config(
    materialized = 'view',
    schema = 'staging'
    )
}}

WITH source_data AS (
    SELECT *
    FROM {{ source('bronze', 'orders') }}
),
cleaned_data AS (

    SELECT
        order_id,
        customer_id,
        store_id,
        order_timestamp,
        LOWER(TRIM(payment_method)) AS payment_method,
        CASE
            WHEN LOWER(TRIM(order_status)) IN ('completed', 'pending', 'cancelled', 'returned') THEN LOWER(TRIM(order_status))
            ELSE 'unknown'
        END AS order_status,
        CAST(total_amount AS DECIMAL(16,2)) AS total_amount,
        created_timestamp,
        updated_timestamp,
        {{clean_is_active('is_active')}} AS is_active
    FROM source_data
)

SELECT *
FROM cleaned_data
