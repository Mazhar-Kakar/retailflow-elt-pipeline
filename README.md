# 🛒 RetailFlow ELT Pipeline

An end-to-end modern ELT pipeline that extracts retail sales data from PostgreSQL, stores raw data in Amazon S3, loads it into Snowflake, transforms it using dbt, and prepares analytics-ready marts for Power BI dashboards.

---

## 📌 Project Overview

RetailFlow simulates a real-world retail data platform where transactional data is ingested from an operational database and transformed into a business-ready data warehouse.

The project follows the Medallion Architecture (Bronze → Staging → Intermediate → Fact/Dimension → Marts) and demonstrates modern data engineering practices using cloud technologies.

---

## 🏗️ Architecture

<p align="center">
  <img src="/project images/Retailflow_Architecture.png" width="900">
</p>

---

## 🚀 Tech Stack

- Python
- PostgreSQL
- Amazon S3
- Snowflake
- dbt Core
- SQL
- Pandas
- SQLAlchemy
- PyArrow

---

## 📂 Project Structure

```
retailflow-elt-pipeline/

│
├── ingestion_scripts/
│   ├── pipelines/
│   ├── extract/
│   ├── load/
│   ├── validation/
|   ├── database/
│   └── metadata/
│
├── dbt_project/
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   ├── marts/
│   │   ├── facts/
│   │   └── marts/
│   │
│   ├── snapshots/
│   └── macros/
│
└── README.md
```

---

## ⚙️ ELT Workflow

### 1. Extract

- Extract retail data from PostgreSQL with Incremental Extraction and loading
- Validate schema
- Convert to Parquet format

### 2. Load

- Upload Parquet files to Amazon S3 Partitioned by date
- Load raw data into Snowflake Bronze layer using `COPY INTO`

### 3. Transform

Using dbt:

- Clean and standardize data
- Validate business rules
- Join datasets
- Build Fact and Dimension tables
- Create Business Data Marts

---

## 🧱 Data Warehouse Layers

### Bronze

Raw data loaded from Amazon S3 into Snowflake.

Tables

- customers
- orders
- order_items
- products
- stores

---

### Staging

Data cleaning and standardization.

Examples:

- Trim whitespace
- Standardize emails
- Validate order status
- Boolean conversion
- Data quality checks

---

### Intermediate

Business-ready joins between staging models.

Examples:

- Customer Orders
- Order Details

---

### Fact & Dimension Models

Dimensions

- dim_customers
- dim_products
- dim_stores

Fact

- fact_orders

---

### Business Marts

- mart_sales_summary
- mart_customer_sales
- mart_product_performance

---

## 📊 KPIs

The project generates business-ready metrics such as:

- Total Revenue
- Total Orders
- Average Order Value
- Units Sold
- Customer Lifetime Value
- Product Revenue
- Best Selling Products
- Customer Purchase History

---

## ✨ Features

- End-to-End ELT Pipeline
- Parquet-based ingestion
- Snowflake Data Warehouse
- dbt Transformations
- Star Schema Modeling
- Incremental-ready Fact Models
- incremental loading
- SCD Type 2 using snapshot
- Data Validation
- Business Data Marts
- Modular Project Structure

---

## ▶️ Getting Started

### Clone Repository

```bash
git clone https://github.com/Mazhar-Kakar/retailflow-elt-pipeline.git
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Configure Environment

Create a `.env` file.

```env
POSTGRES_HOST=
POSTGRES_PORT=
POSTGRES_DATABASE=
POSTGRES_USER=
POSTGRES_PASSWORD=

AWS_ACCESS_KEY=
AWS_SECRET_KEY=

SNOWFLAKE_ACCOUNT=
SNOWFLAKE_USER=
SNOWFLAKE_PASSWORD=
```

### Run Pipeline

```bash
python -m ingestion.pipelines.customer_pipeline
python -m ingestion.pipelines.orders_pipeline
python -m ingestion.pipelines.products_pipeline
```

### Run dbt

```bash
dbt snapshot
dbt run
dbt test
```

---

## 🎯 Future Improvements

- Apache Airflow orchestration
- CI/CD with GitHub Actions
- dbt Documentation
- Data Quality Tests

---

## 👨‍💻 Author

**Mazhar Kakar**

Aspiring Data Engineer
Always learning, building, and solving real-world data problems.