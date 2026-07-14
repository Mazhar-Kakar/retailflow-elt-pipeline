{{
    config(
        materialized='view',
        schema='marts'
    )
}}

SELECT

    dp.product_id,

    dp.product_name,

    dp.category,

    dp.brand,

    COUNT(DISTINCT fo.order_id) AS total_orders,

    SUM(fo.quantity) AS units_sold,

    SUM(fo.line_amount) AS total_revenue,

    ROUND(AVG(fo.unit_price),2) AS average_selling_price

FROM {{ ref('fact_orders') }} fo

INNER JOIN {{ ref('dim_products') }} dp
ON fo.product_id = dp.product_id

WHERE fo.order_status = 'completed'

GROUP BY

    dp.product_id,
    dp.product_name,
    dp.category,
    dp.brand