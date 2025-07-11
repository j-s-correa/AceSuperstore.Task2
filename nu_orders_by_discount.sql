SELECT 
    fs.discount_percent,
    COUNT(*) AS number_of_orders,
    AVG(fs.profit_per_unit) AS avg_profit_per_unit,
    AVG(fs.margin_percent) AS avg_margin
FROM fact_sales fs
GROUP BY fs.discount_percent
ORDER BY fs.discount_percent;
