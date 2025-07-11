-- ==========================================================================================
-- POPULATE DIMENSION AND FACT TABLES FOR SALES ANALYTICS WAREHOUSE
-- Target Platform: SQL Server Management Studio 21
-- File: populate_dimensions.sql
-- Author: Juan Correa
-- ==========================================================================================

-- 🧭 Context:
-- This script populates all dimension tables and the main fact table.
-- Data comes from a single denormalized source table: dbo.AceSuperstore (CSV imported into SQL Server).
-- Challenges we addressed:
--    - Duplicated Customer_IDs across multiple rows (same ID, different address/location)
--    - Discount and Margin columns stored as text with % symbols
--    - Some numeric columns containing nulls or non-numeric text
--    - Invalid foreign keys if NULLs aren't filtered out

-- ==========================================================================================
-- STEP 1: POPULATE dim_customer (using deduplication via ROW_NUMBER)
-- ==========================================================================================

-- ⚠️ Some Customer_IDs appeared multiple times with different cities or regions.
-- We only want ONE row per unique Customer_ID → Use ROW_NUMBER() + CTE

WITH RankedCustomers AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY [Customer_ID] ORDER BY [Customer_ID]) AS rn
    FROM dbo.AceSuperstore
    WHERE [Customer_ID] IS NOT NULL
)
INSERT INTO dim_customer (customer_id, city, postal_code, country, region)
SELECT 
    [Customer_ID],
    [City],
    [Postal_Code],
    [Country],
    [Region]
FROM RankedCustomers
WHERE rn = 1;
-- Why? This avoids duplicates in the dimension and ensures clean joins from fact_sales.

-- ==========================================================================================
-- STEP 2: POPULATE dim_product
-- ==========================================================================================

INSERT INTO dim_product (product_id, product_name, plain_category, category, sub_category)
SELECT DISTINCT 
    [Product_ID],
    [Product_Name],
    [Plain_Category],
    [Category],
    [Sub_Category]
FROM dbo.AceSuperstore
WHERE [Product_ID] IS NOT NULL;
-- Why? Products are stable dimension values; we use DISTINCT to avoid duplicates.

-- ==========================================================================================
-- STEP 3: POPULATE dim_date
-- ==========================================================================================

INSERT INTO dim_date (order_date, day, month, quarter, year)
SELECT DISTINCT 
    CAST([Order_Date] AS DATE),
    DATEPART(DAY, CAST([Order_Date] AS DATE)),
    DATEPART(MONTH, CAST([Order_Date] AS DATE)),
    DATEPART(QUARTER, CAST([Order_Date] AS DATE)),
    DATEPART(YEAR, CAST([Order_Date] AS DATE))
FROM dbo.AceSuperstore
WHERE [Order_Date] IS NOT NULL;
-- Why? We want to allow grouping by day/month/year in dashboards and queries.

