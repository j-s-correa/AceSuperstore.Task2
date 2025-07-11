# 📊 Ace Superstore Data Warehouse Project

This project presents a dimensional model and dashboarding solution for **Ace Superstore**, focused on enabling robust business analysis using **Microsoft SQL Server** and **Tableau**. A star schema was designed to structure and aggregate retail sales data efficiently.

---

## 📁 Contents

* [⭐ Star Schema Overview](#-star-schema-overview)
* [📂 Table Purpose & Description](#-table-purpose--description)
* [🛠️ SQL Server Setup Instructions](#-sql-server-setup-instructions)
* [📊 Tableau Connection & Visualisation](#-tableau-connection--visualisation)
* [🖼️ Screenshots](#-screenshots)

---

## ⭐ Star Schema Overview

The schema follows a **star schema** model with one central fact table and three supporting dimension tables.

### 📌 **Schema Diagram**

📄 [AceSuperstore.Schema.pdf](./AceSuperstore.Schema.pdf)

---

## 📂 Table Purpose & Description

| Table Name     | Type      | Purpose                                                            |
| -------------- | --------- | ------------------------------------------------------------------ |
| `fact_sales`   | Fact      | Captures transactional-level sales including revenue, cost, profit |
| `dim_date`     | Dimension | Enables time-based slicing: year, quarter, month, day              |
| `dim_customer` | Dimension | Customer location data: city, region, country, postal code         |
| `dim_product`  | Dimension | Product metadata: name, category, subcategory                      |

> 🧙 Views created for Tableau analysis:
> `vw_full_sales_details`, `vw_region_sales_performance`, `vw_discount_impact`, `vw_sales_summary`

---

## 🛠️ SQL Server Setup Instructions

### 1. **Create Tables**

```sql
-- Dimension: Customer
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    region VARCHAR(50)
);

-- Dimension: Product
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    plain_category VARCHAR(255),
    category VARCHAR(255),
    sub_category VARCHAR(255)
);

-- Dimension: Date
CREATE TABLE dim_date (
    order_date DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);

-- Fact Table: Sales
CREATE TABLE fact_sales (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    order_mode VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT,
    discount FLOAT,
    final_sales_per_unit FLOAT,
    total_sales_discount_included FLOAT,
    total_sales_discount_not_included FLOAT,
    final_cost FLOAT,
    total_revenue FLOAT,
    profit_per_unit FLOAT,
    margin_percent FLOAT,
    FOREIGN KEY (order_date) REFERENCES dim_date(order_date),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
```

### 2. **Insert Data**

Use the SQL Server import wizard or bulk insert commands to load data from provided CSV files into each dimension and fact table.

### 3. **Create SQL Views**

```sql
-- View: Full Sales Detail
CREATE VIEW vw_full_sales_details AS
SELECT
    fs.*,
    dc.city, dc.region, dc.country,
    dp.product_name, dp.category, dp.sub_category,
    dd.year, dd.month, dd.quarter
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date dd ON fs.order_date = dd.order_date;
```

Repeat for:

* `vw_region_sales_performance`: Aggregated revenue by region and time
* `vw_discount_impact`: Comparison between full-price vs. discounted sales
* `vw_sales_summary`: Top-N city aggregation with total revenue

---

## 📊 Tableau Connection & Visualisation

### Steps:

1. Open **Tableau Desktop**
2. Connect to your SQL Server database
3. Add **one view per connection** (e.g. `vw_full_sales_details`, `vw_region_sales_performance`, etc.)
4. Create separate **Sheets**:

   * Sheet 1: Revenue over time by region
   * Sheet 2: Sales by Product (YoY)
   * Sheet 3: Cost vs Sales
   * Sheet 4: Top N cities (with parameterized dropdown)
   * Sheet 5: Discount vs Full Price comparison
5. Use **Dashboards** to combine relevant sheets
6. Use **Stories** to present business narratives (4 total)

### Publishing

* Extract views and publish to Tableau Public
* 🔗 [Ace Superstore Tableau Public](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis#1)

---

## 🖼️ Screenshots

### 📑 Story 1: Regional Revenue Over Time

> Total revenue peaked in 2024 before dropping in 2025 (only 3 months of data). The lower chart shows monthly fluctuations across regions.

### 📑 Story 2: Product-Level Sales YoY

> Compares sales performance for individual products year over year using stacked bars and category filters.

### 📑 Story 3: Category-Level Cost vs Sales

> Compares final costs and total sales across product categories using vertically stacked bar charts.

### 📑 Story 4: Top Cities & Discount Analysis

> Top 10 cities by revenue (parameter-driven). Also compares average full-price vs. discounted sales and margin impact.

---

## ✅ Deliverables Summary

* ✔️ Star schema with 1 fact + 3 dimension tables
* ✔️ SQL implementation: create + insert + views
* ✔️ Tableau connection to SQL Server
* ✔️ Dashboards and 4 business stories with captions
* ✔️ Tableau Public publishing + screenshots placeholder

---

## 🚀 Next Steps

- [ ] Clean and upload source data (CSV or Excel)
- [ ] Insert values into the dimension and fact tables
- [ ] Write and run SQL queries for business analysis
- [ ] Build dashboards in Power BI or Tableau
- [ ] Document schema relationships visually

---

## 📌 Example Use Cases

- Top-selling products per region
- Monthly margin and revenue trends
- Impact of discounts on profitability
- Product category contribution to overall sales

---

## 📎 License

MIT License

---

## 👤 Author

Developed by **[Your Name]**  
As part of the **RDAMP Superstore SQL Project**
