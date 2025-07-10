# 🛒 Ace Superstore Data Warehouse Project

This project builds a **dimensional data model** using a **star schema** to support data analysis and reporting for a fictional retail company. It simulates how modern data teams design scalable, query-efficient schemas for business intelligence.

---

## ⚙️ Technologies Used

- 🐍 Python with **SQLite** (via `%%sql` magic in Jupyter/Colab)
- 🖥️ **Microsoft SQL Server 2021+** using SQL Server Management Studio (SSMS)
- 📄 Excel / CSV files (original dataset source)

---

## ⭐ Star Schema Design

This model uses the **star schema** architecture, composed of:

```
                    dim_date
                        ↑
                        |
dim_customer ← fact_sales → dim_product
```

### 📂 Tables and Roles

| Table Name     | Type         | Description                                                  |
|----------------|--------------|--------------------------------------------------------------|
| `fact_sales`   | Fact Table   | Central table storing transaction-level sales information    |
| `dim_customer` | Dimension    | Contains customer and location data                          |
| `dim_product`  | Dimension    | Contains product metadata: categories, subcategories         |
| `dim_date`     | Dimension    | Holds calendar information for time-based aggregation        |

---

## 🐍 SQLite Implementation in Python

### ✅ Step 1: Load SQLite in Notebook

```python
%load_ext sql
%sql sqlite:///superstore.db
```

### ✅ Step 2: Create Tables with `%%sql` Magic

```sql
%%sql
CREATE TABLE dim_customer (
    customer_id TEXT PRIMARY KEY,
    city TEXT,
    postal_code TEXT,
    country TEXT,
    region TEXT
);

CREATE TABLE dim_product (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    plain_category TEXT,
    category TEXT,
    sub_category TEXT
);

CREATE TABLE dim_date (
    order_date TEXT PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);

CREATE TABLE fact_sales (
    order_id TEXT PRIMARY KEY,
    order_date TEXT,
    order_mode TEXT,
    customer_id TEXT,
    product_id TEXT,
    quantity INT,
    discount FLOAT,
    final_sales_per_unit FLOAT,
    total_sales_discount_included FLOAT,
    total_sales_discount_not_included FLOAT,
    final_cost FLOAT,
    total_revenue FLOAT,
    profit_per_unit FLOAT,
    margin_percent FLOAT,
    FOREIGN KEY(order_date) REFERENCES dim_date(order_date),
    FOREIGN KEY(customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY(product_id) REFERENCES dim_product(product_id)
);
```

---

## 🖥️ SQL Server Implementation (SSMS)

This version uses SQL Server Management Studio (SSMS 2021 or later) for database-level implementation.

### ✅ Step 1: Create a New Query in SSMS

Paste and execute the following:

```sql
-- Dimension: Customer
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    city VARCHAR(100),
    postal_code VARCHAR(50),
    country VARCHAR(100),
    region VARCHAR(100)
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

---

## 📅 Why Use a `dim_date` Table?

Using a separate `dim_date` dimension enables:
- Better performance than calculating dates in every query
- Simplified filtering by day, month, quarter, year
- Better integration with BI tools like Power BI and Tableau

You can populate it using a calendar generator in Python or a SQL script.

---

## 🧠 Comparison Table

| Feature                     | SQLite + Python | SQL Server (SSMS) |
|----------------------------|------------------|-------------------|
| Rapid prototyping          | ✅ Fast           | ⚠️ Slower setup    |
| Foreign key enforcement    | ⚠️ Manual         | ✅ Strict          |
| BI tool integration        | ⚠️ Limited        | ✅ Excellent       |
| Query performance          | ⚠️ Limited        | ✅ Optimized       |
| Portability                | ✅ Lightweight    | ⚠️ Requires setup  |

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
