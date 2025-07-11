INSERT INTO dim_product (product_id, product_name, plain_category, category, sub_category)
SELECT DISTINCT 
    [Product_ID],
    [Product_Name],
    [Plain_Category],
    [Category],
    [Sub_Category]
FROM dbo.AceSuperstore
WHERE [Product_ID] IS NOT NULL;
