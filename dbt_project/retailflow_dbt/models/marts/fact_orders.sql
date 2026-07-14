{{
  config(
    materialized = 'table',
    schema = 'fact'
    )
}}

WITH fact_orders AS (
    
    SELECT 
        order_id,
        customer_id,
        store_id, 
        order_timestamp,
        payment_method,
        order_status,
        total_amount,
        order_is_active,

        order_item_id,
        product_id,
        quantity,
        unit_price,
        line_amount, 
        is_valid_line_amount,
        order_item_is_active
    FROM {{ ref('int_order_details') }}
)

SELECT *
FROM fact_orders
