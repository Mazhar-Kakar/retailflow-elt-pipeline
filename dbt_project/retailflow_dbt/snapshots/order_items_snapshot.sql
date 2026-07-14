{% snapshot order_items_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_item_id',

        strategy='check',
        check_cols=['unit_price']
    )
}}

SELECT *
FROM {{ source('staging', 'stg_order_items') }}

{% endsnapshot %}