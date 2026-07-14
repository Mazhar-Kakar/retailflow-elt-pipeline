{{
  config(
    materialized = 'view',
    schema = 'intermediate'
    )
}}

WITH order_details AS (
  SELECT
      o.order_id,
      o.customer_id,
      o.store_id,
      o.order_timestamp,
      o.payment_method,
      o.order_status,
      o.total_amount,
      o.is_active AS order_is_active,

      oi.order_item_id,
      oi.product_id,
      oi.quantity,
      oi.unit_price,
      oi.line_amount,
      oi.is_valid_line_amount,
      oi.is_active AS order_item_is_active,

      p.product_name,
      p.category,
      p.brand,
      p.price,
      p.is_active AS product_is_active
  FROM {{ ref('stg_orders') }} o 
  INNER JOIN {{ ref('stg_order_items') }} oi 
    ON o.order_id = oi.order_id
  INNER JOIN {{ ref('stg_products') }} p 
    ON oi.product_id = p.product_id
)

SELECT * 
FROM order_details

