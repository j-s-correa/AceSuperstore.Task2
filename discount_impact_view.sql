-- View 7: Discount Impact on Sales
CREATE VIEW vw_discount_impact AS
SELECT
    fs.discount_percent,
    COUNT(*) AS transaction_count,
    AVG(fs.total_sales_disc_inc) AS avg_discounted_sales,
    AVG(fs.total_sales_disc_not_inc) AS avg_full_price_sales,
    AVG(fs.total_revenue) AS avg_revenue,
    AVG(fs.margin_percent) AS avg_margin
FROM fact_sales fs
GROUP BY fs.discount_percent;

