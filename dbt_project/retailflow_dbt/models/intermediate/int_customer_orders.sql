{{
  config(
    materialized = 'view',
    schema = 'intermediate'
    )
}}

WITH customer_orders AS (

    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        c.email,
        c.city,
        c.province,
        c.country,
        c.is_active AS customer_is_active,

        o.order_id,
        o.store_id,
        o.order_timestamp,
        o.payment_method,
        o.order_status,
        o.total_amount,
        o.is_active AS order_is_active
    FROM {{ ref('stg_customers') }} c 
    INNER JOIN {{ ref('stg_orders') }} o
      ON c.customer_id = o.customer_id
)

SELECT * 
FROM customer_orders





