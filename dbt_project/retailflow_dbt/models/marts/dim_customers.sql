{{ config(
    materialized='table',
    schema='dim'
) }}

WITH customers AS (

    SELECT
        customer_id,
        CONCAT(first_name, ' ', last_name) AS full_name,
        email,
        city,
        province,
        country,
        created_timestamp,
        is_active
    FROM {{ ref('stg_customers') }}

)

SELECT *
FROM customers