{{
    config(
        materialized='view',
        schema='marts'
    )
}}

SELECT
    DATE(order_timestamp) AS order_date,

    COUNT(DISTINCT order_id) AS total_orders,

    SUM(line_amount) AS total_revenue,

    SUM(quantity) AS total_items_sold,

    ROUND(AVG(total_amount),2) AS average_order_value

FROM {{ ref('fact_orders') }}

WHERE order_status = 'completed'

GROUP BY DATE(order_timestamp)
ORDER BY order_date