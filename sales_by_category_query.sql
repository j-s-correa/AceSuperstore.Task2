SELECT 
    p.category,
    SUM(fs.total_sales_disc_inc) AS total_sales,
    AVG(fs.margin_percent) AS avg_margin
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;
