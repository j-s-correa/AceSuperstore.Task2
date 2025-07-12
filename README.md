# 📦 Ace Superstore Data Warehouse Project

This project implements a dimensional model for **Ace Superstore** using **Microsoft SQL Server Management Studio (SSMS)** and **Tableau Desktop**, enabling efficient business analysis through dashboards and KPI reporting.

---

## 📁 Project Structure

The repository is organised into logical components for SQL development and Tableau visualisation. The `README.md` is structured to mirror the key stages of the data pipeline and model design.

<img width="443" height="371" alt="image" src="https://github.com/user-attachments/assets/b866b0ae-a8ed-489c-8b54-6fe886428096" />


## 📚 Contents

- [🛠 Tools Used](#-tools-used)  
- [🌟 Dimensional Schema Overview](#-dimensional-schema-overview)  
- [📌 Table Design & Purpose](#-table-design--purpose)  
- [🏗 Table Creation & Data Population](#-table-creation--data-population)  
- [🔎 View & Query Creation](#-view--query-creation)  
- [📊 Tableau Visualisation Pipeline](#-tableau-visualisation-pipeline)  
- [🖼️ Dashboard Screenshots](#-dashboard-screenshots)

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

📄 Reference: [AceSuperstore.Schema.pdf](https://github.com/user-attachments/files/21191314/AceSuperstore.Schema.pdf)


---

## 🏗 Table Creation & Data Population

The process began with the creation of the database in SQL Server Management Studio (SSMS). The raw **.csv** dataset was first cleaned manually in Excel using functions like VLOOKUP, aggregation formulas, and checks for empty or inconsistent cells.

### 🔧 Data Cleaning Summary

- Negative values in the **Sales** column were corrected using absolute values.
- Negative values in the **Cost Price** column were cleaned to ensure accurate calculations.
- Empty cells in the **Discount** column were replaced with `0`. While NULL values could be used, this step was not strictly necessary for the analysis.

<img width="1143" height="610" alt="image" src="https://github.com/user-attachments/assets/a855ddb9-4b71-499a-8b56-dec9398abc15" />
<img width="955" height="645" alt="image" src="https://github.com/user-attachments/assets/7bd125a4-d8e9-47af-a8f5-f1c45bff67ac" />

**Cleaned .csv**: [Juan.CorreaAceSuperstore.FullyCleaned.csv](https://github.com/user-attachments/files/21197289/Juan.CorreaAceSuperstore.FullyCleaned.csv)

The process was carried out using the dataset initially flagged for some **negative values** in the **`Cost`** and **`Sales`** columns, but for this analysis, I proceeded with a **not fully cleaned version**.

After cleaning, I imported the `.csv` into a **staging table** in **SQL Server**. This temporary table allowed me to perform additional **validation and transformations** within SQL, such as using the `CAST` function for **data type compatibility** and ensuring the structure matched the final **dimensional model**.

From the **staging table**, I populated the fact and dimension tables, carefully handling duplicates (e.g., repeated customer IDs) to avoid redundant entries, especially in products and customers. This step ensured that only clean, properly typed, and deduplicated data flowed into the final schema.

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

The cleaned .csv dataset was imported into a staging table using SQL Server’s built-in **Import and Export Wizard**. This feature allows easy transfer of data from external files into the database, enabling further transformation and validation before loading into the final dimensional model.

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

## 📂 All insert scripts are stored in the [`/sql/`](https://github.com/j-s-correa/AceSuperstore.Task2/tree/main/sql) directory.

---

## 🔎 View & Query Creation

Multiple **SQL views** and **queries** were created to support Tableau integration. These included:

- 📍 **Revenue Aggregation by Region and Time**  
- 🎯 **Sales Performance: Discounted vs Full-Price Orders**  
- 🥇 **Top 10 Most Profitable Product Categories**  
- 📈 **Monthly Profitability by Discount Tier**  
- 🏙️ **Top-N Analysis by City, Product, and Customer Segments**

<img width="392" height="270" alt="image" src="https://github.com/user-attachments/assets/aaa617e8-ae6a-47d8-894c-7dfa1a3516fc" />  
<img width="746" height="696" alt="image" src="https://github.com/user-attachments/assets/472b877b-e02e-439c-835b-683f161d096f" />  
<img width="712" height="736" alt="image" src="https://github.com/user-attachments/assets/90097978-c6c7-4b12-acc2-0e9b31b285ef" />

### ✅ Reusable SQL Queries

The repository includes **5 reusable SQL scripts** outside of views that:

- Join the fact and dimension tables  
- Return strategic business KPIs  

<img width="772" height="724" alt="image" src="https://github.com/user-attachments/assets/7ca69b7e-45e7-47ac-a4bf-4e073691b40c" />
<img width="773" height="716" alt="image" src="https://github.com/user-attachments/assets/ee5394d4-7ce6-4e74-9e49-431a12c3c950" />

## 📁 View the queries and views in the [`/sql/`](https://github.com/j-s-correa/AceSuperstore.Task2/tree/main/sql) folder.


---

## 📊 Tableau Visualisation Pipeline

### Process Overview:

1. Create SQL views in SSMS  
2. Connect Tableau Desktop to those views  
3. Build dashboards using 3 primary views  
4. Combine into a **Tableau Story** to communicate key business insights  
5. Publish final output to **Tableau Public**  

<img width="810" height="476" alt="image" src="https://github.com/user-attachments/assets/d679f7b3-e873-4190-a5ff-5f101b9edb29" />

## 🌐 View Dashboard on Tableau Public

Explore the interactive Tableau dashboard:

🔗 [View Dashboard on Tableau Public](https://public.tableau.com/app/profile/juan.correa./viz/AceSuperstoreTask2/AceSuperstoreAnalysis)

---

## 🖼️ Dashboard Screenshots

Key insights captured from the dashboard:

- 📍 Revenue by region  
- 📦 Sales by product  
- 💰 Cost vs Sales analysis  
- 📈 Year-over-Year comparisons (Revenue, Discount, Margin, Total Sales)  
- 🎯 Top-N analysis using parameter controls (e.g., Top Cities)
- 📍 Heatmap - Product Seasonality Trends YoY

<img width="274" height="166" alt="image" src="https://github.com/user-attachments/assets/d2f5288f-f1c6-42b6-a17a-95df372897f0" />  
<img width="280" height="572" alt="image" src="https://github.com/user-attachments/assets/b57b0526-1b26-4ca5-9536-89204467c1c8" />  
<img width="1011" height="487" alt="image" src="https://github.com/user-attachments/assets/61033932-4a96-47f2-b771-238722beb880" />
<img width="879" height="724" alt="image" src="https://github.com/user-attachments/assets/3fbc2750-1509-44e3-b7d5-0335d218970a" />
<img width="963" height="740" alt="image" src="https://github.com/user-attachments/assets/e2dfe9c9-55dc-4708-82f8-46ea92636b31" />
<img width="857" height="738" alt="image" src="https://github.com/user-attachments/assets/bf1c79b4-7103-4d1d-ae24-864954503c4c" />
<img width="832" height="734" alt="image" src="https://github.com/user-attachments/assets/ba8ddab6-79ce-4a18-9b2f-8c8d336fedcd" />

#### Top N & Bottom N Revenue Analysis

This subsection presents visual comparisons of the **Top and Bottom Cities and Products by Total Revenue**, including cases where **margins or revenues are negative**. Some visuals use an in-house parameter to dynamically filter Top N results for deeper insight.

Included screenshots:
- Bottom and top orders by revenue, displayed with associated **category** and **region**.
- Highest-performing **products**, spotlighting strong contributors.
- Lowest-performing **orders**, capturing underperforming or loss-generating transactions.

This was **built** to clearly **show negative outcomes** from certain orders, making potential losses visibly apparent and easier to analyse. These dashboards help surface key geographic and product-based revenue patterns to support targeted business decisions.


<img width="971" height="817" alt="image" src="https://github.com/user-attachments/assets/4126d3de-d2fa-4df1-93f7-d9238d6fdd4b" />
<img width="891" height="689" alt="image" src="https://github.com/user-attachments/assets/858a7550-b882-48d1-9c15-fd9571cabd98" />



---

### 📦 Download Complete Project Files (.zip)

All files for this project — including SQL scripts, Tableau workbook, screenshots, and documentation — are available in a single compressed archive:

🔽 [Download RDAMP Project Files (.zip)] [JuanCorrea.Ace.Insights.zip](https://github.com/user-attachments/files/21198737/JuanCorrea.Ace.Insights.zip)








