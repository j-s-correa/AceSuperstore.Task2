CREATE VIEW vw_SalesSummary AS
SELECT 
    fs.order_id,
    fs.order_date,
    dp.product_name,
    dc.city,
    fs.total_revenue,
    fs.profit_per_unit
FROM 
    fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_customer dc ON fs.customer_id = dc.customer_id;
