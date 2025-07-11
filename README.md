# 📊 Ace Superstore Data Warehouse Project

This project focuses on building a retail data warehouse for **Ace Superstore** using **Microsoft SQL Server** for backend processing and **Tableau** for business intelligence and reporting.

---

## 📅 Table of Contents

* [Star Schema Overview](#star-schema-overview)
* [Table Purpose and Description](#table-purpose-and-description)
* [Tools Used](#tools-used)
* [Project Folder Structure](#project-folder-structure)
* [SQL Setup Instructions](#sql-setup-instructions)
* [Views and Queries](#views-and-queries)
* [Tableau Dashboards](#tableau-dashboards)
* [Screenshots](#screenshots)

---

## ✨ Star Schema Overview

This project uses a **Star Schema** model that includes:

* 1 Fact Table: `fact_sales`
* 3 Dimension Tables: `dim_customer`, `dim_product`, `dim_date`

### 📄 Schema Diagram

View the full diagram here: [AceSuperstore.Schema.pdf](./tableau/schema_diagram.pdf)

---

## 📂 Table Purpose and Description

| Table Name     | Type      | Purpose                                     |
| -------------- | --------- | ------------------------------------------- |
| `fact_sales`   | Fact      | Stores all sales transactions with metrics  |
| `dim_customer` | Dimension | Includes city, region, postal code, country |
| `dim_product`  | Dimension | Product category, name, subcategory         |
| `dim_date`     | Dimension | Time details: year, month, day, quarter     |

> Additional analysis views were created and stored under the `sql/` folder.

---

## 🔧 Tools Used

| Tool                 | Description                                |
| -------------------- | ------------------------------------------ |
| Microsoft SQL Server | Backend data modeling, views, and queries  |
| Tableau              | Dashboard creation and visual storytelling |
| Excel/CSV            | Used for raw data imports                  |
| GitHub               | Version control and project structure      |

---

## 📁 Project Folder Structure

```plaintext
AceSuperstore-DW/
├── sql/
│   ├── create_tables.sql
│   ├── insert_datetable.sql
│   ├── insert_customertable.sql
│   ├── insert_product.table.sql
│   ├── insert_fact_sales.table.sql
│   ├── full_sales_details_view.sql
│   ├── discount_impact_view.sql
│   ├── regionwise_sales_performance_view.sql
│   ├── SalesSummary_view.sql
│   ├── top10_products_by_revenue_view.sql
├── tableau/
│   ├── AceSuperstoreDashboard.twbx
│   ├── screenshots/
│   └── schema_diagram.pdf
```

---

## 🚧 SQL Setup Instructions

### 1. Create Tables (see `sql/create_tables.sql`)

```sql
CREATE TABLE dim_product (
  product_id VARCHAR(50) PRIMARY KEY,
  product_name VARCHAR(255),
  plain_category VARCHAR(255),
  category VARCHAR(255),
  sub_category VARCHAR(255)
);
```

### 2. Insert Data into Dimension Tables

Each `.csv` was uploaded into a staging table (`dbo.AceSuperstore`). Example for `dim_customer`:

```sql
WITH RankedCustomers AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Customer_ID) AS rn
  FROM dbo.AceSuperstore
)
INSERT INTO dim_customer (customer_id, city, postal_code, country, region)
SELECT Customer_ID, City, Postal_Code, Country, Region
FROM RankedCustomers WHERE rn = 1;
```

See files:

* `insert_customertable.sql`
* `insert_datetable.sql`
* `insert_product.table.sql`

### 3. Insert Data into Fact Table

See: `insert_fact_sales.table.sql`

```sql
INSERT INTO fact_sales (...)
SELECT ... FROM dbo.AceSuperstore
WHERE Order_ID IS NOT NULL;
```

---

## 🔍 Views and Queries

All analytical views and queries are in the `sql/` folder. Notable examples:

* `full_sales_details_view.sql`
* `discount_impact_view.sql`
* `SalesSummary_view.sql`
* `top10_products_by_revenue_view.sql`
* `sales_by_category_query.sql`

---

## 📊 Tableau Dashboards

### Steps:

1. Open Tableau Desktop
2. Connect to SQL Server and load relevant views
3. Build sheets for:

   * Revenue Over Time by Region
   * Product Sales YoY
   * Category Cost vs Sales
   * Top Cities by Revenue
   * Discount vs Full Price Analysis
4. Combine into dashboards and stories

### Published Link:

[Access on Tableau Public](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis#1)

---

## 🖼️ Screenshots

> Screenshots for each story/dashboard view are stored under `tableau/screenshots/`

* Story 1: Regional Revenue Over Time
* Story 2: Product Sales YoY
* Story 3: Category-Level Cost vs Sales
* Story 4: Top Cities & Discount Impact

---

## ✅ Summary Checklist

| Component                 | Status    |
| ------------------------- | --------- |
| Schema Design             | ✅ Done    |
| SQL Scripts & Populations | ✅ Done    |
| Views & Queries           | ✅ Done    |
| Tableau Dashboards        | ✅ Done    |
| Screenshots               | ☑ Pending |

---

This README ensures complete documentation of the warehouse design, data loading steps, and business storytelling through Tableau.


- 📦 Fully normalized star schema with documented purpose
- 🧩 SQL scripts for schema, data, and views
- 📊 Tableau dashboards and published stories
- 🖼️ Screenshots and PDF schema attached
