{{
    config(
        materialized='view',
        schema='marts'
    )
}}

SELECT

    dc.customer_id,

    dc.full_name,

    dc.city,

    dc.country,

    COUNT(DISTINCT fo.order_id) AS total_orders,

    SUM(fo.line_amount) AS total_spent,

    ROUND(AVG(fo.total_amount),2) AS average_order_value,

    MAX(fo.order_timestamp) AS last_purchase_date

FROM {{ ref('fact_orders') }} fo

INNER JOIN {{ ref('dim_customers') }} dc
ON fo.customer_id = dc.customer_id

WHERE fo.order_status = 'completed'

GROUP BY

    dc.customer_id,
    dc.full_name,
    dc.city,
    dc.country