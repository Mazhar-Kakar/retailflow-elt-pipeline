{{
  config(
    materialized = 'view',
    schema = 'intermediate'
    )
}}

WITH store_orders AS (

    SELECT
        o.order_id,
        o.customer_id,
        o.store_id,
        o.order_timestamp,
        o.payment_method,
        o.order_status,
        o.total_amount,
        o.is_active AS order_is_active,

        s.store_name,
        s.city AS store_city,
        s.province AS store_province,
        s.country AS store_country,
        s.is_active AS store_is_active
    FROM {{ ref('stg_orders') }} o
    INNER JOIN {{ ref('stg_stores') }} s 
      ON o.store_id = s.store_id
)

SELECT *
FROM store_orders