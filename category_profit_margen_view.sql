-- View 5: Category-Wise Profit Margins
-- Allows evaluation of average profit margins by 
-- product category to identify which categories are most (or least) profitable.
CREATE VIEW vw_category_profit_margin AS
SELECT
    p.category,
    AVG(fs.margin_percent) AS avg_margin_percent,
    SUM(fs.total_revenue) AS total_revenue,
    SUM(fs.total_revenue) - SUM(fs.final_cost) AS total_profit
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
GROUP BY p.category;
