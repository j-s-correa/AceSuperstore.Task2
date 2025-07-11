# 📦 Ace Superstore Data Warehouse Project

This project implements a dimensional model for **Ace Superstore** using **Microsoft SQL Server Management Studio (SSMS)** and **Tableau Desktop**, enabling efficient business analysis through dashboards and KPI reporting.

---

## 📚 Contents

- 🛠 Tools Used  
- 🌟 Dimensional Schema Overview  
- 📌 Table Design & Purpose  
- 🏗 Table Creation & Data Population  
- 🔎 View & Query Creation  
- 📊 Tableau Visualisation Pipeline  
- 🖼️ Dashboard Screenshots  

---

## 🛠 Tools Used

The following tools were used across the project lifecycle:

- **Microsoft SQL Server Management Studio (SSMS)** – For table creation, data transformation, and view generation  
- **CSV file input** – Initial raw dataset imported using SQL Server Import Wizard  
- **Tableau Desktop** – For building interactive dashboards and visual stories  
- **Tableau Public** – For publishing dashboards online  
- **GitHub** – For version control and structured file organisation  

---

## 🌟 Dimensional Schema Overview

The project follows a **star schema** structure comprising:

- **1 fact table** capturing transactional sales metrics  
- **3 dimension tables** providing context for date, customer, and product data  

---

## 📌 Table Design & Purpose

| Table Name     | Type       | Description                                                     |
|----------------|------------|-----------------------------------------------------------------|
| `fact_sales`   | Fact        | Contains revenue, cost, and profit data for each sale           |
| `dim_date`     | Dimension   | Enables time-based analysis (year, quarter, month, day)         |
| `dim_customer` | Dimension   | Captures geographic and customer-level segmentation             |
| `dim_product`  | Dimension   | Categorises products by type, category, and subcategory         |

This schema allows for slicing and filtering across multiple business dimensions efficiently.

📄 Reference: `AceSuperstore.Schema.pdf`

---

## 🏗 Table Creation & Data Population

The process began with the creation of the database in SSMS. The raw `.csv` dataset was uploaded as a **staging table** to support cleaning and transformation before final loading into dimensional and fact tables.

<img width="940" height="662" alt="image" src="https://github.com/user-attachments/assets/9710a1bd-0c71-4bf5-b688-ceceebb51153" />  
<img width="940" height="639" alt="image" src="https://github.com/user-attachments/assets/3c237fff-42e4-4b9f-98d0-be7f849e4901" />  
<img width="940" height="718" alt="image" src="https://github.com/user-attachments/assets/e58c165a-0f10-4d05-bd16-b9f0d4bda1f5" />

### ✅ Table Creation

All base tables were created using **SQL DDL scripts** within SSMS. The schema design follows dimensional modelling standards, including:

- Appropriate data types  
- Primary key definitions  
- Foreign key relationships to ensure referential integrity  

<img width="461" height="477" alt="image" src="https://github.com/user-attachments/assets/75585efa-d394-4d1f-8a49-fc714237779a" />  
<img width="329" height="445" alt="image" src="https://github.com/user-attachments/assets/16b86f0b-5d2d-46d5-8ecf-2cfb4079c67f" />

### ✅ Data Loading

The raw dataset was imported into a staging table using SQL Server’s built-in **Import Wizard**. This enabled:

- **Data cleaning** before final load  
- **Type casting** (e.g., converting string to numeric types)  
- **Validation** (e.g., ensuring valid `Customer_ID`, `Product_ID`, and `Order_Date`)  

This ensures no invalid or duplicate data contaminates the core warehouse.

### ✅ Dimension Populations

For each dimension:

- Duplicates were removed via `ROW_NUMBER()` + `PARTITION BY` logic  
- Null or invalid keys were excluded  
- Fields were cleaned and renamed for clarity  

This step preserves **dimension integrity** and ensures reliable foreign key joins with the fact table.

### ✅ Fact Table Population

The `fact_sales` table was populated with cleaned transactional records from the staging table.

📂 All insert scripts are stored in the `/sql/` directory.

---

## 🔎 View & Query Creation

Multiple **SQL views** and **queries** were created to support Tableau integration. These included:

- Revenue aggregation by region and time  
- Discounted vs full-price sales comparison  
- Top-N insights by city, product, and customer  

<img width="392" height="270" alt="image" src="https://github.com/user-attachments/assets/aaa617e8-ae6a-47d8-894c-7dfa1a3516fc" />  
<img width="746" height="696" alt="image" src="https://github.com/user-attachments/assets/472b877b-e02e-439c-835b-683f161d096f" />  
<img width="712" height="736" alt="image" src="https://github.com/user-attachments/assets/90097978-c6c7-4b12-acc2-0e9b31b285ef" />

### ✅ Reusable SQL Queries

The repository includes **5 reusable SQL scripts** outside of views that:

- Join fact and dimension tables  
- Return strategic business KPIs  

📁 View the queries in the `/sql/` folder.

---

## 📊 Tableau Visualisation Pipeline

### Process Overview:

1. Create SQL views in SSMS  
2. Connect Tableau Desktop to those views  
3. Build dashboards using 3 primary views  
4. Combine into a **Tableau Story** to communicate key business insights  
5. Publish final output to **Tableau Public**  

<img width="810" height="476" alt="image" src="https://github.com/user-attachments/assets/d679f7b3-e873-4190-a5ff-5f101b9edb29" />

🔗 **View Dashboard on Tableau Public**

---

## 🖼️ Dashboard Screenshots

Key insights captured from the dashboard:

- 📍 Revenue by region  
- 📦 Sales by product  
- 💰 Cost vs Sales analysis  
- 📈 Year-over-Year comparisons (Revenue, Discount, Margin, Total Sales)  
- 🎯 Top-N analysis using parameter controls (e.g., Top Cities)

<img width="274" height="166" alt="image" src="https://github.com/user-attachments/assets/d2f5288f-f1c6-42b6-a17a-95df372897f0" />  
<img width="280" height="572" alt="image" src="https://github.com/user-attachments/assets/b57b0526-1b26-4ca5-9536-89204467c1c8" />  
<img width="1011" height="487" alt="image" src="https://github.com/user-attachments/assets/61033932-4a96-47f2-b771-238722beb880" />
