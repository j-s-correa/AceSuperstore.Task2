INSERT INTO dim_date (order_date, day, month, quarter, year)
SELECT DISTINCT
    CAST([Order_Date] AS DATE),
    DAY(CAST([Order_Date] AS DATE)),
    MONTH(CAST([Order_Date] AS DATE)),
    DATEPART(QUARTER, CAST([Order_Date] AS DATE)),
    YEAR(CAST([Order_Date] AS DATE))
FROM dbo.AceSuperstore
WHERE [Order_Date] IS NOT NULL;
