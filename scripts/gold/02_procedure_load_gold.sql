 -- File     : scripts/gold/02_procedure_load_gold.sql
 -- Layer    : Gold
 -- Purpose  : Procedure gold.load_superstore: loads the dimensions, then the fact table
 -- Run order: 7
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- load dimensions and fact table
CREATE OR ALTER PROCEDURE gold.load_superstore
AS
BEGIN
    -- Clean old data first
    DELETE FROM gold.FactSales;
    DELETE FROM gold.DimCustomer;
    DELETE FROM gold.DimProduct;
    DELETE FROM gold.DimLocation;
    DELETE FROM gold.DimShipMode;
    DELETE FROM gold.DimDate;
    -- Load Customer dimension
    INSERT INTO gold.DimCustomer
        (CustomerID, CustomerName, Segment)
    SELECT DISTINCT
        CustomerID, CustomerName, Segment
    FROM silver.superstore_clean
    WHERE CustomerID IS NOT NULL
      AND CustomerName IS NOT NULL
      AND Segment IS NOT NULL;
    -- Load Product dimension
    INSERT INTO gold.DimProduct
        (ProductID, ProductName, Category, SubCategory)
    SELECT DISTINCT
        ProductID, ProductName, Category, SubCategory
    FROM silver.superstore_clean
    WHERE ProductID IS NOT NULL
      AND ProductName IS NOT NULL
      AND Category IS NOT NULL
      AND SubCategory IS NOT NULL;
    -- Load Location dimension
    INSERT INTO gold.DimLocation
        (Country, StateName, City, PostalCode, Region)
    SELECT DISTINCT
        Country, State, City, PostalCode, Region
    FROM silver.superstore_clean
    WHERE Country IS NOT NULL
      AND State IS NOT NULL
      AND City IS NOT NULL
      AND PostalCode IS NOT NULL
      AND Region IS NOT NULL;
    -- Load Shipping Mode dimension
    INSERT INTO gold.DimShipMode (ShipMode)
    SELECT DISTINCT ShipMode
    FROM silver.superstore_clean
    WHERE ShipMode IS NOT NULL;
    -- Load Date dimension
    INSERT INTO gold.DimDate (
        FullDate, YearNumber, QuarterNumber,
        MonthNumber, MonthName, DayNumber
    )
    SELECT
        D.FullDate,
        YEAR(D.FullDate),
        CASE
            WHEN MONTH(D.FullDate) BETWEEN 1 AND 3 THEN 1
            WHEN MONTH(D.FullDate) BETWEEN 4 AND 6 THEN 2
            WHEN MONTH(D.FullDate) BETWEEN 7 AND 9 THEN 3
            ELSE 4
        END,
        MONTH(D.FullDate),
        DATENAME(MONTH, D.FullDate),
        DAY(D.FullDate)
    FROM (
        SELECT OrderDate AS FullDate
        FROM silver.superstore_clean
        WHERE OrderDate IS NOT NULL
        UNION
        SELECT ShipDate
        FROM silver.superstore_clean
        WHERE ShipDate IS NOT NULL
    ) AS D;
    -- Load Sales Fact table
    INSERT INTO gold.FactSales ( OrderID, CustomerKey,
        ProductKey, LocationKey, ShipModeKey,
        OrderDateKey, ShipDateKey,
        Sales, Quantity, Discount, Profit, ShippingDays
    )
    SELECT
        S.OrderID,
        C.CustomerKey,
        P.ProductKey,
        L.LocationKey,
        SM.ShipModeKey,
        OD.DateKey,
        SD.DateKey,
        S.Sales,
        S.Quantity,
        S.Discount,
        S.Profit,
        S.ShippingDays
    FROM silver.superstore_clean AS S
    INNER JOIN gold.DimCustomer AS C
        ON S.CustomerID = C.CustomerID
    INNER JOIN gold.DimProduct AS P
        ON S.ProductID = P.ProductID
       AND S.ProductName = P.ProductName
    INNER JOIN gold.DimLocation AS L
        ON S.Country = L.Country
       AND S.State = L.StateName
       AND S.City = L.City
       AND S.PostalCode = L.PostalCode
       AND S.Region = L.Region
    INNER JOIN gold.DimShipMode AS SM
        ON S.ShipMode = SM.ShipMode
    INNER JOIN gold.DimDate AS OD
        ON S.OrderDate = OD.FullDate
    INNER JOIN gold.DimDate AS SD
        ON S.ShipDate = SD.FullDate;
END;
GO
-- Execute Gold ETL
EXEC gold.load_superstore;
GO
