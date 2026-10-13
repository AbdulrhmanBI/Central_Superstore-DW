 -- File     : scripts/silver/01_procedure_load_silver.sql
 -- Layer    : Silver
 -- Purpose  : Procedure silver.load_superstore: TRIM, NULLIF, type casts, DISTINCT (removes duplicates), ShippingDays
 -- Run order: 4
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Silver layer: stores cleaned and transformed data
CREATE OR ALTER PROCEDURE silver.load_superstore
AS
BEGIN
    -- Rebuild the Silver table
    DROP TABLE IF EXISTS silver.superstore_clean;
    CREATE TABLE silver.superstore_clean (
        RowID INT NOT NULL,
        OrderID NVARCHAR(255),
        OrderDate DATE,
        ShipDate DATE,
        ShipMode NVARCHAR(255),
        CustomerID NVARCHAR(255),
        CustomerName NVARCHAR(255),
        Segment NVARCHAR(255),
        Country NVARCHAR(255),
        City NVARCHAR(255),
        State NVARCHAR(255),
        PostalCode NVARCHAR(255),
        Region NVARCHAR(255),
        ProductID NVARCHAR(255),
        Category NVARCHAR(255),
        SubCategory NVARCHAR(255),
        ProductName NVARCHAR(255),
        Sales DECIMAL(20,5),
        Quantity INT,
        Discount DECIMAL(20,5),
        Profit DECIMAL(20,5),
        ShippingDays INT
    );
    -- Load cleaned data into Silver
    INSERT INTO silver.superstore_clean (
        RowID, OrderID, OrderDate, ShipDate, ShipMode,
        CustomerID, CustomerName, Segment, Country, City,
        State, PostalCode, Region, ProductID, Category,
        SubCategory, ProductName, Sales, Quantity,
        Discount, Profit, ShippingDays
    )
    SELECT DISTINCT
        CAST([Row ID] AS INT),
        NULLIF(TRIM([Order ID]), ''),
        CAST([Order Date] AS DATE),
        CAST([Ship Date] AS DATE),
        NULLIF(TRIM([Ship Mode]), ''),
        NULLIF(TRIM([Customer ID]), ''),
        NULLIF(TRIM([Customer Name]), ''),
        NULLIF(TRIM([Segment]), ''),
        NULLIF(TRIM([Country]), ''),
        NULLIF(TRIM([City]), ''),
        NULLIF(TRIM([State]), ''),
        CAST(CAST([Postal Code] AS BIGINT) AS NVARCHAR(255)),
        NULLIF(TRIM([Region]), ''),
        NULLIF(TRIM([Product ID]), ''),
        NULLIF(TRIM([Category]), ''),
        NULLIF(TRIM([Sub-Category]), ''),
        NULLIF(TRIM([Product Name]), ''),
        CAST([Sales] AS DECIMAL(20,5)),
        CAST([Quantity] AS INT),
        CAST([Discount] AS DECIMAL(20,5)),
        CAST([Profit] AS DECIMAL(20,5)),
        -- Calculate shipping days
        DATEDIFF(DAY, [Order Date], [Ship Date]) AS ShippingDays
    FROM bronze.superstore_raw;
END;
GO
-- Execute Silver ETL
EXEC silver.load_superstore;
GO