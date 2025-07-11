-- View 3: Monthly Sales Trend
CREATE VIEW vw_monthly_sales_trend AS
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
