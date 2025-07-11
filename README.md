# 📊 Ace Superstore Data Warehouse Project

A complete retail data warehousing project for **Ace Superstore**, implemented using **Microsoft SQL Server** and visualized via **Tableau**. The pipeline transforms transactional data into a dimensional model for analytical reporting.

---

## 📁 Table of Contents

- [⭐ Star Schema Overview](#-star-schema-overview)
- [📂 Table Purpose & Description](#-table-purpose--description)
- [🔧 Tools Used](#-tools-used)
- [🛠️ Folder Structure](#-folder-structure)
- [🧱 SQL Table Creation](#-sql-table-creation)
- [📥 Data Insertion](#-data-insertion)
- [🔍 Views & Queries](#-views--queries)
- [📊 Tableau Visualisation](#-tableau-visualisation)
- [🖼️ Screenshots](#-screenshots)

---

## ⭐ Star Schema Overview

This warehouse uses a classic **star schema**, composed of:

- 1 central fact table: `fact_sales`
- 3 dimensions: `dim_customer`, `dim_product`, and `dim_date`

📌 **Schema Diagram**:  
📄 [AceSuperstore.Schema.pdf](./AceSuperstore.Schema.pdf)

---

## 📂 Table Purpose & Description

| Table         | Type      | Description                                                    |
|---------------|-----------|----------------------------------------------------------------|
| `fact_sales`  | Fact      | Captures transactional-level sales, cost, discount, margin     |
| `dim_date`    | Dimension | Enables time-based slicing: year, quarter, month, day          |
| `dim_customer`| Dimension | Stores customer location attributes                            |
| `dim_product` | Dimension | Contains category-level product metadata                        |

📌 Views Used:
- `vw_full_sales_details`
- `vw_discount_impact`
- `vw_region_sales_performance`
- `vw_sales_summary`
- Others: see [`sql/`](./sql)

---

## 🔧 Tools Used

| Tool            | Purpose                                             |
|-----------------|-----------------------------------------------------|
| **SQL Server**  | Schema creation, transformation, view/query logic   |
| **Tableau**     | Dashboarding, interactive storytelling              |
| **Excel/CSV**   | Source dataset loaded into staging using import wizard |
| **GitHub**      | Version control and project repository              |

---

## 🛠️ Folder Structure

AceSuperstore-DW/
├── sql/
│ ├── create_tables.sql
│ ├── insert_datetable.sql
│ ├── insert_customertable.sql
│ ├── insert_product.table.sql
│ ├── insert_fact_sales.table.sql
│ ├── full_sales_details_view.sql
│ ├── discount_impact_view.sql
│ ├── category_profit_margin_view.sql
│ ├── regionwise_sales_performance_view.sql
│ ├── top10_products_by_revenue_view.sql
│ ├── queries.sql
├── tableau/
│ ├── AceSuperstoreDashboard.twbx
│ ├── screenshots/
│ ├── schema_diagram.pdf

sql
Copy
Edit

---

## 🧱 SQL Table Creation

See [`create_tables.sql`](./sql/create_tables.sql)

Example:

```sql
CREATE TABLE dim_product (
  product_id VARCHAR(50) PRIMARY KEY,
  product_name VARCHAR(255),
  plain_category VARCHAR(255),
  category VARCHAR(255),
  sub_category VARCHAR(255)
);
📥 Data Insertion
All .csv files were imported using SQL Server Import Wizard into a staging table: dbo.AceSuperstore.

Then, dedicated SQL scripts populated the dimension and fact tables.

Example: dim_customer (see insert_customertable.sql)
sql
Copy
Edit
WITH RankedCustomers AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Customer_ID) AS rn
  FROM dbo.AceSuperstore
)
INSERT INTO dim_customer (customer_id, city, postal_code, country, region)
SELECT Customer_ID, City, Postal_Code, Country, Region
FROM RankedCustomers WHERE rn = 1;
Example: fact_sales (see insert_fact_sales.table.sql)
sql
Copy
Edit
INSERT INTO fact_sales (...)
SELECT 
    Order_ID, CAST(Order_Date AS DATE), Order_Mode, Customer_ID, Product_ID,
    TRY_CAST(Sales AS FLOAT), TRY_CAST(Cost_Price AS FLOAT),
    TRY_CAST(Quantity AS INT), TRY_CAST(REPLACE(Discount, '%', '') AS FLOAT),
    ...
FROM dbo.AceSuperstore
WHERE Order_ID IS NOT NULL;
🔍 Views & Queries
Views are stored in:

full_sales_details_view.sql

discount_impact_view.sql

regionwise_sales_performance_view.sql

SalesSummary_view.sql

top10_products_by_revenue_view.sql

Query files:

sales_by_category_query.sql

top10_most_profitable_products_query.sql

monthly_sales_trend_by_region_query.sql

etc.

📊 Tableau Visualisation
Launch Tableau Desktop

Connect to SQL Server

Add views as data sources

Create sheets:

Revenue Over Time

Sales by Product YoY

Cost vs Sales by Category

Top Cities

Discount vs Full Price

Combine into Dashboards

Create Stories

🔗 Published version:
Tableau Public – Ace Superstore Analysis

🖼️ Screenshots
📍 Screenshots of each dashboard/story will go here.

Story 1: Regional Revenue Trend

Story 2: Product-Level YoY Sales

Story 3: Category Cost vs Sales

Story 4: Top Cities + Discount Analysis

📁 Folder: /tableau/screenshots

✅ Project Completion Checklist
Task	Status
Star Schema Model	✅ Done
SQL Tables & Inserts	✅ Done
View Creation & Queries	✅ Done
Tableau Integration	✅ Done
Dashboard Stories	✅ Done
Screenshots Added	⬜ (Pending)
---

## ✅ Deliverables Summary

- 📦 Fully normalized star schema with documented purpose
- 🧩 SQL scripts for schema, data, and views
- 📊 Tableau dashboards and published stories
- 🖼️ Screenshots and PDF schema attached
