-- View 1: Full Sales Details with Dimensions
CREATE VIEW vw_full_sales_details AS
SELECT
    fs.order_id,
    fs.order_date,
    fs.order_mode,
    c.customer_id,
    c.city,
    c.postal_code,
    c.country,
    c.region,
    p.product_id,
    p.product_name,
    p.plain_category,
    p.category,
    p.sub_category,
    fs.sales,
    fs.cost_price,
    fs.quantity,
    fs.discount_percent,
    fs.final_sales_per_unit,
    fs.total_sales_disc_inc,
    fs.total_sales_disc_not_inc,
    fs.final_cost,
    fs.total_revenue,
    fs.profit_per_unit,
    fs.margin_percent,
    d.day,
    d.month,
    d.quarter,
    d.year
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
JOIN dim_product p ON fs.product_id = p.product_id
JOIN dim_date d ON fs.order_date = d.order_date;
