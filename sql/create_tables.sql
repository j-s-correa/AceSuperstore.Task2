-- ===============================================================
-- CREATE TABLES FOR SALES DATA WAREHOUSE
-- Target Platform: SQL Server Management Studio 21 (SSMS 21)
-- File Name: create_tables.sql
-- Purpose: To normalise and prepare the dataset for structured analysis
-- Author: Juan Correa
-- ===============================================================

-- STEP 1: CREATE DATABASE
-- This command creates a dedicated database for our warehouse.

CREATE DATABASE AceSuperStore;
GO

-- Use the new database
USE AceSuperStore;
GO

-- WHY THIS FILE?
-- The raw dataset includes transactional data that mixes customers, dates, products, and sales.
-- To support clean, efficient analytics, we normalise the structure into:
--    - Dimension Tables (descriptive reference info)
--    - Fact Table (quantitative sales events)
-- This allows slicing, aggregating, and reporting with much greater flexibility.

-- ============================================================
-- STEP 2: CREATE TABLES
-- ============================================================

-- ======================
-- 1. Dimension: Customer
-- ======================
CREATE TABLE dim_customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    region VARCHAR(100)
);
-- Why? This keeps all customer-related info in one place for lookup and joining.

-- ======================
-- 2. Dimension: Product
-- ======================
CREATE TABLE dim_product (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(255),
    plain_category VARCHAR(100),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);
-- Why? Products can be grouped by type/category for product-level analysis.

-- ====================
-- 3. Dimension: Date
-- ====================
CREATE TABLE dim_date (
    order_date DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);
-- Why? This enables easy grouping by month, quarter, and year for time-based analysis.

-- ====================
-- 4. Fact Table: Sales
-- ====================
CREATE TABLE fact_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE FOREIGN KEY REFERENCES dim_date(order_date),
    customer_id VARCHAR(20) FOREIGN KEY REFERENCES dim_customer(customer_id),
    product_id VARCHAR(20) FOREIGN KEY REFERENCES dim_product(product_id),
    order_mode VARCHAR(50),
    sales FLOAT,
    cost_price FLOAT,
    quantity INT,
    discount_percent FLOAT,
    final_sales_per_unit FLOAT,
    total_sales_disc_inc FLOAT,
    total_sales_disc_not_inc FLOAT,
    final_cost FLOAT,
    total_revenue FLOAT,
    profit_per_unit FLOAT,
    margin_percent FLOAT
);
-- Why? This table captures the core business event: the sale.
-- It ties together product, customer, and time, and stores all financial metrics.

-- ============================================================
-- NOTE:
-- After running this script:
--   → Import your cleaned CSVs using the SSMS Import Wizard
--   → Use INSERT INTO or BULK INSERT for automation
--   → Create indexes and views as needed for performance
--   → Maintain foreign key integrity for consistent reporting
-- ============================================================


