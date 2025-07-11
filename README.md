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
* **GitHub** – for version control and structured file organisation.

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
| `dim_product`  | Dimension | Categorises products by type, category, and subcategory. |

This schema enables slicing and filtering across multiple business dimensions efficiently.

Link wih the schema
[AceSuperstore.Schema.pdf](https://github.com/user-attachments/files/21190864/AceSuperstore.Schema.pdf)

---

## 🏗 Table Creation & Data Population
correct this sayin that i create ddatabase and then upload the .csv fort late bei able to create tables
<img width="940" height="662" alt="image" src="https://github.com/user-attachments/assets/9710a1bd-0c71-4bf5-b688-ceceebb51153" />
<img width="940" height="639" alt="image" src="https://github.com/user-attachments/assets/3c237fff-42e4-4b9f-98d0-be7f849e4901" />
<img width="940" height="718" alt="image" src="https://github.com/user-attachments/assets/e58c165a-0f10-4d05-bd16-b9f0d4bda1f5" />



### ✅ Table Creation

All base tables were created using SQL DDL scripts within Microsoft SQL Server Management Studio. The design adheres to data warehousing standards, with appropriate data types, primary keys, and foreign key relationships between fact and dimension tables.

<img width="461" height="477" alt="image" src="https://github.com/user-attachments/assets/75585efa-d394-4d1f-8a49-fc714237779a" />
<img width="329" height="445" alt="image" src="https://github.com/user-attachments/assets/16b86f0b-5d2d-46d5-8ecf-2cfb4079c67f" />



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

<img width="392" height="270" alt="image" src="https://github.com/user-attachments/assets/aaa617e8-ae6a-47d8-894c-7dfa1a3516fc" />
<img width="746" height="696" alt="image" src="https://github.com/user-attachments/assets/472b877b-e02e-439c-835b-683f161d096f" />
<img width="712" height="736" alt="image" src="https://github.com/user-attachments/assets/90097978-c6c7-4b12-acc2-0e9b31b285ef" />



---

## 📊 Tableau Visualisation Pipeline

### Process Overview:

1. **Create views** in SQL Server Management Studio.
2. **Connect Tableau Desktop** to those views.
3. **Build dashboards** based on three main views.
4. **Combine into a Story**, explaining key insights.
5. **Publish to Tableau Public** for external sharing.
<img width="810" height="476" alt="image" src="https://github.com/user-attachments/assets/d679f7b3-e873-4190-a5ff-5f101b9edb29" />


🔗 [View Dashboard on Tableau Public](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis#1)

---

## 🖼️ Dashboard Screenshots


```

They capture:

tableau capture the next through the views used
<img width="274" height="166" alt="image" src="https://github.com/user-attachments/assets/d2f5288f-f1c6-42b6-a17a-95df372897f0" />
<img width="280" height="572" alt="image" src="https://github.com/user-attachments/assets/b57b0526-1b26-4ca5-9536-89204467c1c8" />


* Revenue by region
* Sales by Products
* Cost vs Sales
* Totals Analysis includng revenues, discount, sales and margin YoY

a parament were used to measure the top N cieties as well see the story in tabelau public
<img width="1011" height="487" alt="image" src="https://github.com/user-attachments/assets/61033932-4a96-47f2-b771-238722beb880" />


---


```

---

Please refer to this `README.md` as a complete documentation of the warehouse design, SQL setup, data flow, and dashboarding process.

