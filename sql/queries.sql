-- ==========================================================================================
-- AD HOC ANALYTICAL QUERIES
-- File: queries.sql
-- Platform: SQL Server Management Studio 21
-- Author: Juan Correa
-- ==========================================================================================

-- ✅ Why This File?
-- Now that we’ve modeled the data warehouse using a star schema (fact_sales + dimensions),
-- we can run powerful JOIN-based queries to extract business insights cleanly and efficiently.
-- These queries reflect common use cases in analytics and dashboarding.
-- ==========================================================================================


-- ==========================================================================================
-- QUERY 1: Top 10 Most Profitable Products
-- ==========================================================================================
SELECT TOP 10
    p.product_name,
    SUM(fs.total_revenue) AS total_revenue,
    SUM(fs.final_cost) AS total_cost,
    SUM(fs.total_revenue - fs.final_cost) AS total_profit
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC;
-- 🎯 Why? Identifies which products generate the highest total profit, not just revenue.


-- ==========================================================================================
-- QUERY 2: Monthly Sales Trend by Region
-- ==========================================================================================
SELECT 
    d.year,
    d.month,
    c.region,
    SUM(fs.total_sales_disc_inc) AS total_sales
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
JOIN dim_date d ON fs.order_date = d.order_date
GROUP BY d.year, d.month, c.region
ORDER BY d.year, d.month, c.region;
-- 🎯 Why? Tracks how different regions are performing over time — helpful for spotting growth or seasonality.


-- ==========================================================================================
-- QUERY 3: Profitability by Product Category
-- ==========================================================================================
SELECT 
    p.category,
    AVG(fs.margin_percent) AS avg_margin,
    SUM(fs.total_revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_margin DESC;
-- 🎯 Why? Helps identify which product categories are not just selling, but selling profitably.


-- ==========================================================================================
-- QUERY 4: Sales by Region and Country
-- ==========================================================================================
SELECT 
    c.region,
    c.country,
    SUM(fs.total_sales_disc_inc) AS total_sales
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.region, c.country
ORDER BY total_sales DESC;
-- 🎯 Why? Supports geographic analysis and helps understand where most revenue is being generated.


-- ==========================================================================================
-- QUERY 5: Discount Impact on Profitability
-- ==========================================================================================
SELECT 
    fs.discount_percent,
    COUNT(*) AS transaction_count,
    AVG(fs.total_sales_disc_inc) AS avg_discounted_sales,
    AVG(fs.total_sales_disc_not_inc) AS avg_full_price_sales,
    AVG(fs.total_revenue) AS avg_revenue,
    AVG(fs.margin_percent) AS avg_margin
FROM fact_sales fs
GROUP BY fs.discount_percent
ORDER BY fs.discount_percent;
-- 🎯 Why? Evaluates how different discount levels affect revenue and profitability.

-- ==========================================================================================
-- ✅ All queries above are now possible because we used a normalised star schema model.
-- The `fact_sales` table contains measurable facts, while dimensions enable filtering,
-- grouping, and segmentation for clean business intelligence workflows.
-- ==========================================================================================

