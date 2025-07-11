-- ==========================================================================================
-- POPULATE FACT TABLE FOR SALES DATA WAREHOUSE
-- File: populate_fact_table.sql
-- Platform: SQL Server Management Studio 21
-- Author: Juan Correa
-- ==========================================================================================

-- 🧭 Purpose:
-- This script populates the `fact_sales` table with cleaned, casted data from the original
-- flat table (dbo.AceSuperstore). It assumes that the dimension tables have been created and
-- loaded with distinct values for customer, product, and date.
-- ==========================================================================================

-- STEP 1: Insert into fact_sales with casting and key references

INSERT INTO fact_sales (
    order_id, 
    order_date, 
    order_mode, 
    customer_id, 
    product_id,
    sales, 
    cost_price, 
    quantity, 
    discount_percent,
    final_sales_per_unit, 
    total_sales_disc_inc, 
    total_sales_disc_not_inc,
    final_cost, 
    total_revenue, 
    profit_per_unit, 
    margin_percent
)
SELECT 
    [Order_ID],
    CAST([Order_Date] AS DATE),
    [Order_Mode],
    [Customer_ID],
    [Product_ID],
    TRY_CAST([Sales] AS FLOAT),
    TRY_CAST([Cost_Price] AS FLOAT),
    TRY_CAST([Quantity] AS INT),
    TRY_CAST(REPLACE([Discount], '%', '') AS FLOAT),
    TRY_CAST([Final_Sales_per_unit] AS FLOAT),
    TRY_CAST([Total_Sales_disc_inc] AS FLOAT),
    TRY_CAST([Total_Sales_disc_not_inc] AS FLOAT),
    TRY_CAST([Final_Cost] AS FLOAT),
    TRY_CAST([Total_Revenue] AS FLOAT),
    TRY_CAST([Profit_per_unit] AS FLOAT),
    TRY_CAST(REPLACE([Margin], '%', '') AS FLOAT)
FROM dbo.AceSuperstore
WHERE 
    [Order_ID] IS NOT NULL
    AND [Customer_ID] IS NOT NULL
    AND [Product_ID] IS NOT NULL
    AND [Order_Date] IS NOT NULL;
-- ==========================================================================================

-- ✅ Explanation of Key Transformations:
-- - REPLACE('%', '') handles text-based percentage values in Discount and Margin
-- - TRY_CAST ensures that malformed or null numeric values don’t break the load
-- - WHERE clause ensures no NULLs are inserted into foreign key columns

-- ✅ Assumptions:
-- - All referenced `customer_id`, `product_id`, and `order_date` already exist in their respective dimensions
-- - No duplicate Order_IDs in dbo.AceSuperstore
-- - Your import preserved correct data formats for numeric fields

-- ==========================================================================================
-- ✅ Done
-- Your `fact_sales` table is now fully populated and joins cleanly with the dimension tables.
-- You can now run analytical queries or build dashboards.
-- ==========================================================================================
