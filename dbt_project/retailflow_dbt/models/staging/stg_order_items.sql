{{
  config(
    materialized = 'view',
    schema = 'staging'
    )
}}

WITH source_data AS (
    SELECT *
    FROM {{ source('bronze', 'order_items') }}
),
cleaned_data AS (

    SELECT
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        line_amount,
        CASE
            WHEN line_amount = (quantity * unit_price) THEN TRUE
            ELSE FALSE
        END AS is_valid_line_amount,
        created_timestamp,
        updated_timestamp,
        {{clean_is_active('is_active')}} AS is_active
    FROM source_data
)

SELECT *
FROM cleaned_data

