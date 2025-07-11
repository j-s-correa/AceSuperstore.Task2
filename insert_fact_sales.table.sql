INSERT INTO fact_sales (
    order_id, order_date, order_mode, customer_id, product_id,
    sales, cost_price, quantity, discount_percent,
    final_sales_per_unit, total_sales_disc_inc, total_sales_disc_not_inc,
    final_cost, total_revenue, profit_per_unit, margin_percent
)
SELECT 
    [Order_ID],
    CAST([Order_Date] AS DATE),
    [Order_Mode],
    [Customer_ID],
    [Product_ID],
    TRY_CAST([Sales] AS FLOAT),
    TRY_CAST([Cost_Price] AS FLOAT),
    TRY_CAST([Quantity] AS INT),
    TRY_CAST(REPLACE([Discount], '%', '') AS FLOAT),
    TRY_CAST([Final_Sales_per_unit] AS FLOAT),
    TRY_CAST([Total_Sales_disc_inc] AS FLOAT),
    TRY_CAST([Total_Sales_disc_not_inc] AS FLOAT),
    TRY_CAST([Final_Cost] AS FLOAT),
    TRY_CAST([Total_Revenue] AS FLOAT),
    TRY_CAST([Profit_per_unit] AS FLOAT),
    TRY_CAST(REPLACE([Margin], '%', '') AS FLOAT)
FROM dbo.AceSuperstore
WHERE [Order_ID] IS NOT NULL;
