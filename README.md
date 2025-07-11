📦 Ace Superstore Data Warehouse Project
This project implements a dimensional model for Ace Superstore using Microsoft SQL Server Management Studio and Tableau Desktop, enabling efficient business analysis through dashboards and KPI reporting.

📚 Contents
🛠 Tools Used

🌟 Dimensional Schema Overview

📌 Table Design & Purpose

🏗 Table Creation & Data Population

🔎 View & Query Creation

📊 Tableau Visualisation Pipeline

🖼️ Dashboard Screenshots

🛠 Tools Used
The following tools were used across the project lifecycle:

Microsoft SQL Server Management Studio (SSMS) – for table creation, data transformation, and view generation.

CSV file input – initial raw dataset imported using SQL Server Import Wizard.

Tableau Desktop – for building interactive dashboards and visual stories.

Tableau Public – for sharing final dashboards online.

GitHub – for version control and structured file organization.

🌟 Dimensional Schema Overview
The project follows a star schema, which consists of:

One fact table capturing transactional sales metrics.

Three dimension tables providing context for date, customer, and product data.

📎 A full schema diagram is included in the repository:
/powerbi/schema_diagram.png

📌 Table Design & Purpose
Table Name	Type	Description
fact_sales	Fact	Contains revenue, cost, and profit data for each sale.
dim_date	Dimension	Enables time-based analysis (year, quarter, month, day).
dim_customer	Dimension	Captures geographic and customer-level segmentation.
dim_product	Dimension	Categorizes products by type, category, and subcategory.

This schema enables slicing and filtering across multiple business dimensions efficiently.

🏗 Table Creation & Data Population
✅ Table Creation
All base tables were created using SQL DDL scripts within Microsoft SQL Server Management Studio. The design adheres to data warehousing standards, with appropriate data types, primary keys, and foreign key relationships between fact and dimension tables.

✅ Data Loading
The raw dataset (CSV format) was imported as a staging table using SQL Server’s built-in import wizard. This allowed cleaning, transformation, and normalization before inserting data into the star schema.

Why this matters:

Prevents inserting invalid or duplicate data.

Allows for casting data types properly (e.g., numeric conversions).

Ensures only valid Customer_ID, Product_ID, and Order_Date values are included.

✅ Dimension Populations
For each dimension:

Duplicates were removed using deduplication logic (e.g., ROW_NUMBER() with PARTITION BY).

Missing keys were excluded using filters.

Columns were renamed and cleaned as necessary.

This ensures dimension integrity and reliable joins with the fact table.

✅ Fact Table Population
The fact table was populated with clean transactional records from the staging table:

% signs were stripped from margin and discount columns.

All numeric columns were safely cast.

Only rows with valid Order_ID and keys were included.

This creates a performant and queryable fact table ready for BI tooling.

🔎 View & Query Creation
Multiple SQL views and analytical queries were created to streamline Tableau reporting. These views pre-aggregate and prepare data for direct use in dashboards.

All related files are located in the /sql/ folder.

Views were designed to:

Summarize revenue by region, time, product, and customer.

Compare full-price vs. discounted sales.

Support top-N queries (e.g., top products, cities, customers).

This structure makes data consumption more efficient and Tableau connections simpler.

📊 Tableau Visualisation Pipeline
Process Overview:
Connect Views from SQL Server
Three cleaned and aggregated views were connected to Tableau Desktop.

Design Sheets
Each sheet represents a specific insight (e.g., revenue trends, discount impact, city sales).

Build Dashboards
Dashboards were built by combining related sheets visually.

Create Storyline
A business story with four dashboards was developed to guide decision-making.

Publish to Tableau Public
The final story was published online for interactive access.

🔗 Final Dashboard Link
View Ace Superstore Story on Tableau Public

🖼️ Dashboard Screenshots
Screenshots of each dashboard have been saved under:

bash
Copy
Edit
/powerbi/screenshots/
These provide visual summaries of:

Revenue trends by region and time.

Year-over-year product performance.

Cost vs sales comparisons.

Top cities and impact of discounts on margins.

✅ Repository Structure
pgsql
Copy
Edit
RDAMP-Dimensional-Model-Power BI/
│
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
