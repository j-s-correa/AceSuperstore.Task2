SELECT TOP 10
    c.customer_id,
    c.country,
    SUM(fs.total_revenue) AS lifetime_revenue,
    COUNT(DISTINCT fs.order_id) AS orders_made
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.customer_id, c.country
ORDER BY lifetime_revenue DESC;
