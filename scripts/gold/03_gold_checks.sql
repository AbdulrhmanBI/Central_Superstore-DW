 -- File     : scripts/gold/03_gold_checks.sql
 -- Layer    : Gold
 -- Purpose  : Row counts and missing-value checks on the star schema
 -- Run order: 8
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Compare Silver and Gold Fact row counts
SELECT COUNT(*) AS SilverRows
FROM silver.superstore_clean;
SELECT COUNT(*) AS FactRows
FROM gold.FactSales;
-- Check Gold table row counts
SELECT COUNT(*) AS TotalRows FROM gold.DimCustomer;
SELECT COUNT(*) AS TotalRows FROM gold.DimProduct;
SELECT COUNT(*) AS TotalRows FROM gold.DimLocation;
SELECT COUNT(*) AS TotalRows FROM gold.DimShipMode;
SELECT COUNT(*) AS TotalRows FROM gold.DimDate;
SELECT COUNT(*) AS TotalRows FROM gold.FactSales;
-- Check missing values in GOLD dimension tables
SELECT
    (SELECT COUNT(*) FROM gold.DimCustomer
      WHERE CustomerID IS NULL OR CustomerName IS NULL OR Segment IS NULL) AS CustomerIssues,
    (SELECT COUNT(*) FROM gold.DimProduct
      WHERE ProductID IS NULL OR ProductName IS NULL
         OR Category IS NULL OR SubCategory IS NULL) AS ProductIssues,
    (SELECT COUNT(*) FROM gold.DimLocation
      WHERE Country IS NULL OR StateName IS NULL OR City IS NULL
         OR PostalCode IS NULL OR Region IS NULL) AS LocationIssues,
    (SELECT COUNT(*) FROM gold.DimShipMode
      WHERE ShipMode IS NULL) AS ShipModeIssues;
GO
