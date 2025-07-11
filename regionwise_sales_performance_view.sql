-- View 4: Region-Wise Sales Performance
CREATE VIEW vw_region_sales_performance AS
SELECT
    c.region,
    SUM(fs.total_sales_disc_inc) AS total_sales,
    SUM(fs.total_revenue) AS total_revenue,
    SUM(fs.total_revenue) - SUM(fs.final_cost) AS total_profit
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.region;
