# 📦 Ace Superstore Data Warehouse Project

This project implements a **dimensional model** for Ace Superstore using **Microsoft SQL Server Management Studio** and **Tableau Desktop**, enabling efficient business analysis through dashboards and KPI reporting.

---

## 📚 Contents

* [🛠 Tools Used](#-tools-used)
* [🌟 Dimensional Schema Overview](#-dimensional-schema-overview)
* [📌 Table Design & Purpose](#-table-design--purpose)
* [🏗 Table Creation & Data Population](#-table-creation--data-population)
* [🔎 View & Query Creation](#-view--query-creation)
* [📊 Tableau Visualisation Pipeline](#-tableau-visualisation-pipeline)
* [🖼️ Dashboard Screenshots](#-dashboard-screenshots)

---

## 🛠 Tools Used

The following tools were used across the project lifecycle:

* **Microsoft SQL Server Management Studio (SSMS)** – for table creation, data transformation, and view generation.
* **CSV file input** – initial raw dataset imported using SQL Server Import Wizard.
* **Tableau Desktop** – for building interactive dashboards and visual stories.
* **Tableau Public** – for sharing final dashboards online.
* **GitHub** – for version control and structured file organization.

---

## 🌟 Dimensional Schema Overview

The project follows a **star schema**, which consists of:

* One **fact table** capturing transactional sales metrics.
* Three **dimension tables** providing context for date, customer, and product data.

📌 A full schema diagram is included in the repository:
`/powerbi/schema_diagram.png`

---

## 📌 Table Design & Purpose

| Table Name     | Type      | Description                                              |
| -------------- | --------- | -------------------------------------------------------- |
| `fact_sales`   | Fact      | Contains revenue, cost, and profit data for each sale.   |
| `dim_date`     | Dimension | Enables time-based analysis (year, quarter, month, day). |
| `dim_customer` | Dimension | Captures geographic and customer-level segmentation.     |
| `dim_product`  | Dimension | Categorizes products by type, category, and subcategory. |

This schema enables slicing and filtering across multiple business dimensions efficiently.

---

## 🏗 Table Creation & Data Population

### ✅ Table Creation

All base tables were created using SQL DDL scripts within Microsoft SQL Server Management Studio. The design adheres to data warehousing standards, with appropriate data types, primary keys, and foreign key relationships between fact and dimension tables.

### ✅ Data Loading

The raw dataset (CSV format) was imported as a staging table using SQL Server’s built-in import wizard. This allowed cleaning, transformation, and normalization before inserting data into the star schema.

**Why this matters:**

* Prevents inserting invalid or duplicate data.
* Allows for casting data types properly (e.g., numeric conversions).
* Ensures only valid `Customer_ID`, `Product_ID`, and `Order_Date` values are included.

### ✅ Dimension Populations

For each dimension:

* Duplicates were removed using deduplication logic (e.g., `ROW_NUMBER()` with `PARTITION BY`).
* Missing keys were excluded using filters.
* Columns were renamed and cleaned as necessary.

This ensures **dimension integrity** and reliable joins with the fact table.

### ✅ Fact Table Population

The fact table was populated with clean transactional records from the staging table:

All relevant insert scripts are included in the `/sql/` folder.

---

## 🔎 View & Query Creation

Multiple views and SQL queries were created to enable seamless Tableau integration. These views:

* Aggregate monthly revenue by region
* Compare full-price vs discounted sales
* Extract top-N metrics by city, customer, and product

All view creation scripts and analytical queries are stored in the `/sql/` directory.

---

## 📊 Tableau Visualisation Pipeline

### Process Overview:

1. **Create views** in SQL Server Management Studio.
2. **Connect Tableau Desktop** to those views.
3. **Build dashboards** based on three main views.
4. **Combine into a Story**, explaining key insights.
5. **Publish to Tableau Public** for external sharing.

🔗 [View Dashboard on Tableau Public](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis#1)

---

## 🖼️ Dashboard Screenshots

Screenshots of all dashboards and story points are available in:

```
/powerbi/screenshots/
```

They capture:

* Monthly revenue by region
* YoY sales performance
* Category-level cost vs revenue
* Top cities and margin breakdown by discount impact

---

## ✅ Repository Structure

```
RDAMP-Dimensional-Model-Power BI/
├── sql/
│   ├── create_tables.sql
│   ├── insert_customertable.sql
│   ├── insert_product.table.sql
│   ├── insert_fact_sales.table.sql
│   ├── insert_datetable.sql
│   ├── [various views & queries].sql
│
├── powerbi/
│   ├── AceSuperstore_Dashboard.pbix
│   ├── screenshots/
│   │   └── [dashboard images].png
│   └── schema_diagram.png
│
└── README.md
```

---

Please refer to this `README.md` as a complete documentation of the warehouse design, SQL setup, data flow, and dashboarding process.

