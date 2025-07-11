--  Top 10 Most Profitable Products
SELECT TOP 10
    p.product_name,
    SUM(fs.total_revenue) AS total_revenue,
    SUM(fs.final_cost) AS total_cost,
    SUM(fs.total_revenue - fs.final_cost) AS total_profit
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC;

