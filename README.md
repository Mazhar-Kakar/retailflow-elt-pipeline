This project is actively being built — not finished yet. I'm adding pieces step by step (extraction, loading, transformation) and updating this README and commit history as I go. Feel free to follow along.

ELT pipeline (Python → S3 → Snowflake → dbt) for retail data analytics.


- stg
- int
- mart

This is Rough work that i am doing
==============================================

Business Requirement:
-----------------------------------------------------------------------------------------------------------
The management wants a Sales Analytics Dashboard to understand customer behavior, store performance, 
product performance, and revenue trends.
The company asks the data team to build a warehouse that enables reporting.
-----------------------------------------------------------------------------------------------------------


Staging Layer (Silver)

Light cleaning only.

stg_customers

Transformations:
Remove duplicate customers
Trim whitespace
Lowercase email
Standardize city/province names
Cast timestamps
Keep only active customers
-----------------------------------------------------------------------------------------------------------

stg_orders

Transformations:
Remove cancelled/invalid orders (if business decides)
Convert timestamps
Validate payment methods
Ensure total_amount > 0
-------------------------------------------------------------------------------------------------------------

stg_products

Transformations:
Standardize category names
Standardize brand names
Remove inactive products
-------------------------------------------------------------------------------------------------------------

stg_stores

Transformations:

Standardize city/country names
Remove inactive stores
--------------------------------------------------------------------------------------------------------------

stg_order_items

Transformations:
Validate quantity > 0
Validate unit_price > 0
Recalculate
--------------------------------------------------------------------------------------------------------------

