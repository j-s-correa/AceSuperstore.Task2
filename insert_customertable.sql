-- 🧼 Remove duplicate Customer_IDs before inserting into dim_customer
-- This ensures each Customer_ID appears only once, avoiding PK constraint violations 
WITH RankedCustomers AS (
    SELECT 
        [Customer_ID],
        [City],
        [Postal_Code],
        [Country],
        [Region],
        ROW_NUMBER() OVER (PARTITION BY [Customer_ID] ORDER BY [Customer_ID]) AS rn
    FROM dbo.AceSuperstore
    WHERE [Customer_ID] IS NOT NULL
)
INSERT INTO dim_customer (customer_id, city, postal_code, country, region)
SELECT 
    [Customer_ID],
    [City],
    [Postal_Code],
    [Country],
    [Region]
FROM RankedCustomers
WHERE rn = 1;
