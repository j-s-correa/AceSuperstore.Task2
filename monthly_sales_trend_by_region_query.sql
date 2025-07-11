--  Monthly Sales Trend by Region
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
