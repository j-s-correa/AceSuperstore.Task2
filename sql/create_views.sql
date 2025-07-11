-- ==========================================================================================
-- CREATE ANALYTICAL VIEWS FOR SALES DATA WAREHOUSE
-- File: create_views.sql
-- Platform: SQL Server Management Studio 21
-- Author: Juan Correa
-- ==========================================================================================

-- ✅ Purpose:
-- Create flattened, query-ready views to support insights, dashboards, and analysis.
-- Views abstract the joins between fact and dimension tables and enable business-friendly querying.

-- ==========================================================================================
-- View 1: Full Sales Details
-- ==========================================================================================
CREATE OR ALTER VIEW vw_full_sales_details AS
SELECT
    fs.order_id,
    fs.order_date,
    fs.order_mode,
    c.customer_id,
    c.city,
    c.postal_code,
    c.country,
    c.region,
    p.product_id,
    p.product_name,
    p.plain_category,
    p.category,
    p.sub_category,
    fs.sales,
    fs.cost_price,
    fs.quantity,
    fs.discount_percent,
    fs.final_sales_per_unit,
    fs.total_sales_disc_inc,
    fs.total_sales_disc_not_inc,
    fs.final_cost,
    fs.total_revenue,
    fs.profit_per_unit,
    fs.margin_percent,
    d.day,
    d.month,
    d.quarter,
    d.year
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
JOIN dim_product p ON fs.product_id = p.product_id
JOIN dim_date d ON fs.order_date = d.order_date;

-- ==========================================================================================
-- View 2: Top 10 Products by Revenue
-- ==========================================================================================
CREATE OR ALTER VIEW vw_top_10_products_by_revenue AS
SELECT TOP 10
    p.product_name,
    SUM(fs.total_revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- ==========================================================================================
-- View 3: Monthly Sales Trend with Profit
-- ==========================================================================================
CREATE OR ALTER VIEW vw_monthly_sales_trend AS
SELECT
    d.year,
    d.month,
    COUNT(DISTINCT fs.order_id) AS total_orders,
    SUM(fs.total_sales_disc_inc) AS total_sales,
    SUM(fs.total_revenue) AS total_revenue,
    SUM(fs.final_cost) AS total_cost,
    SUM(fs.total_revenue) - SUM(fs.final_cost) AS total_profit
FROM fact_sales fs
JOIN dim_date d ON fs.order_date = d.order_date
GROUP BY d.year, d.month;

-- ==========================================================================================
-- View 4: Profitability by Category
-- ==========================================================================================
CREATE OR ALTER VIEW vw_profitability_by_category AS
SELECT 
    p.category,
    AVG(fs.margin_percent) AS avg_margin,
    SUM(fs.total_revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.category;

-- ==========================================================================================
-- View 5: Sales by Region and Country
-- ==========================================================================================
CREATE OR ALTER VIEW vw_sales_by_region_country AS
SELECT 
    c.region,
    c.country,
    SUM(fs.total_sales_disc_inc) AS total_sales
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.region, c.country;

-- ==========================================================================================
-- View 6: Discount Impact on Sales and Margin
-- ==========================================================================================
CREATE OR ALTER VIEW vw_discount_impact AS
SELECT
    fs.discount_percent,
    COUNT(*) AS transaction_count,
    AVG(fs.total_sales_disc_inc) AS avg_discounted_sales,
    AVG(fs.total_sales_disc_not_inc) AS avg_full_price_sales,
    AVG(fs.total_revenue) AS avg_revenue,
    AVG(fs.margin_percent) AS avg_margin
FROM fact_sales fs
GROUP BY fs.discount_percent;

-- ==========================================================================================
-- ✅ Views complete. These are ready to support BI tools (Tableau, Power BI) or direct SQL analysis.
-- ==========================================================================================
