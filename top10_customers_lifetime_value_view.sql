-- View 6: Top 10 Customers by Lifetime Value
CREATE VIEW vw_top10_customers_lifetime_value AS
SELECT TOP 10
    c.customer_id,
    c.city,
    c.region,
    COUNT(DISTINCT fs.order_id) AS total_orders,
    SUM(fs.total_sales_disc_inc) AS total_spent,
    SUM(fs.total_revenue) AS revenue_generated
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.customer_id, c.city, c.region
ORDER BY total_spent DESC;
