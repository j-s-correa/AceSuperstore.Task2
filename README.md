# 📊 Ace Superstore Data Warehouse Project

This project delivers a complete data warehouse pipeline for **Ace Superstore**, using a **star schema** implemented in **Microsoft SQL Server** and visualized with **Tableau**.

---

## 📁 Contents

- [⭐ Star Schema Overview](#-star-schema-overview)
- [📂 Table Purpose & Description](#-table-purpose--description)
- [🛠️ Tool Stack & Workflow](#-tool-stack--workflow)
- [🗃️ SQL Server Setup Instructions](#-sql-server-setup-instructions)
- [📊 Tableau Connection & Visualisation](#-tableau-connection--visualisation)
- [🖼️ Screenshots](#-screenshots)
- [📁 Repository Structure](#-repository-structure)

---

## ⭐ Star Schema Overview

The schema uses a classic **star model** centred around a `fact_sales` table supported by three-dimensional tables.

📌 **Schema Diagram**  
![Ace Superstore Schema](./schema/AceSuperstore.Schema.pdf)

---

## 📂 Table Purpose & Description

| Table Name     | Type      | Description                                                       |
|----------------|-----------|-------------------------------------------------------------------|
| `fact_sales`   | Fact      | Central table storing transactional sales data                    |
| `dim_date`     | Dimension | Enables filtering by day, month, quarter, and year                |
| `dim_customer` | Dimension | Provides location-based segmentation (region, city, postal code)  |
| `dim_product`  | Dimension | Contains product metadata: name, category, sub-category           |

> ✅ Views used in Tableau:  
> `vw_full_sales_details`, `vw_region_sales_performance`, `vw_discount_impact`, `vw_sales_summary`

---

## 🛠️ Tool Stack & Workflow

| Tool             | Purpose                                   |
|------------------|-------------------------------------------|
| Microsoft SQL Server (SSMS) | Schema definition, data loading, views      |
| Excel / CSV Files | Source for dimension and fact data       |
| Tableau Desktop   | Dashboard development                    |
| Tableau Public    | Online publishing                        |

---

## 🗃️ SQL Server Setup Instructions

### Step 1: Create Tables

```sql
CREATE TABLE dim_product (
  product_id VARCHAR(50) PRIMARY KEY,
  product_name VARCHAR(255),
  plain_category VARCHAR(255),
  category VARCHAR(255),
  sub_category VARCHAR(255)
);
-- Repeat for dim_customer, dim_date, fact_sales
```

See: `sql/create_tables.sql`

---

### Step 2: Populate Dimensions

```sql
INSERT INTO dim_product (product_id, product_name, plain_category, category, sub_category)
VALUES ('P001', 'Adjustable Dumbbells', 'Fitness', 'Weights', 'Strength');
```

CSV files were cleaned and imported using SQL Server’s import wizard. See: `sql/populate_dimensions.sql`

---

### Step 3: Populate Fact Table

```sql
INSERT INTO fact_sales (
  order_id, order_date, order_mode, customer_id, product_id, quantity, discount,
  final_sales_per_unit, total_sales_discount_included, total_sales_discount_not_included,
  final_cost, total_revenue, profit_per_unit, margin_percent
)
VALUES (
  'O001', '2024-01-15', 'Online', 'C001', 'P001', 2, 0.15, 45.0,
  76.5, 90.0, 58.0, 121.0, 31.5, 26.0
);
```

See: `sql/populate_fact_table.sql`

---

### Step 4: Create Views

```sql
CREATE VIEW vw_full_sales_details AS
SELECT fs.*, dc.*, dp.*, dd.*
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date dd ON fs.order_date = dd.order_date;
```

See: `sql/create_views.sql`

---

### Step 5: Run Sample Queries

```sql
SELECT TOP 5 city, SUM(total_revenue) AS revenue
FROM vw_full_sales_details
GROUP BY city
ORDER BY revenue DESC;
```

See: `sql/queries.sql`

---

## 📊 Tableau Connection & Visualisation

### ✅ Steps

1. Open **Tableau Desktop**
2. Connect to your SQL Server database
3. Import each view (`vw_...`) as a data source
4. Build the following sheets:
   - Revenue over time by region
   - Product-level YoY sales
   - Category-level cost vs sales
   - Top-N cities (controlled by parameter)
   - Discount vs full-price analysis
5. Combine sheets into **dashboards**
6. Create 4 **storyboards** with captions

🔗 **Tableau Public Dashboard**  
[View Online →](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis#1)

---

## 🖼️ Screenshots

### 📘 Story 1: Regional Revenue

> Total revenue peaked in 2024, dropped in 2025 (partial data). Monthly fluctuations reveal regional seasonality.

### 📙 Story 2: Product YoY Sales

> Year-over-year trends by product with category filtering enabled.

### 📕 Story 3: Category Cost vs Sales

> A two-panel bar chart contrasting revenue vs incurred costs per category.

### 📗 Story 4: City Ranking + Discount

> Parameter controls the top N cities shown. Below is a discount vs full-price sales/margin comparison.

---

## 📁 Repository Structure

```plaintext
AceSuperstore-DataWarehouse/
├── sql/
│   ├── create_tables.sql
│   ├── populate_dimensions.sql
│   ├── populate_fact_table.sql
│   ├── create_views.sql
│   └── queries.sql
│
├── tableau/
│   ├── AceSuperstore_Dashboard.twb
│   └── screenshots/
│       ├── story1.png
│       ├── story2.png
│       ├── story3.png
│       └── story4.png
│
├── schema/
│   └── AceSuperstore.Schema.pdf
│
└── README.md
```

---

## ✅ Deliverables Summary

- 📦 Fully normalized star schema with documented purpose
- 🧩 SQL scripts for schema, data, and views
- 📊 Tableau dashboards and published stories
- 🖼️ Screenshots and PDF schema attached
