-- View 2: Top 10 Products by Revenue
CREATE VIEW vw_top10_products_by_revenue AS
SELECT TOP 10
    p.product_name,
    p.category,
    p.sub_category,
    SUM(fs.total_revenue) AS revenue_generated
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.product_name, p.category, p.sub_category
ORDER BY revenue_generated DESC;
