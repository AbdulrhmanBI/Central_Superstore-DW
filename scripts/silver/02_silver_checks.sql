 -- File     : scripts/silver/02_silver_checks.sql
 -- Layer    : Silver
 -- Purpose  : Compare row counts and test the cleaned data
 -- Run order: 5
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Compare row counts
SELECT COUNT(*) AS BronzeRows
FROM bronze.superstore_raw;
SELECT COUNT(*) AS SilverRows
FROM silver.superstore_clean;
-- Preview cleaned data
SELECT TOP 10 *
FROM silver.superstore_clean;
-- Check duplicate RowIDs
SELECT RowID, COUNT(*) AS Occurrences
FROM silver.superstore_clean
GROUP BY RowID
HAVING COUNT(*) > 1;
-- Check CustomerID consistency
SELECT
    CustomerID,
    COUNT(DISTINCT CustomerName) AS DifferentNames
FROM silver.superstore_clean
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING COUNT(DISTINCT CustomerName) > 1;
-- Check ProductID conflicts
SELECT
    ProductID,
    COUNT(DISTINCT ProductName) AS DifferentNames
FROM silver.superstore_clean
GROUP BY ProductID
HAVING COUNT(DISTINCT ProductName) > 1;
-- Check missing values in SILVER
SELECT
    SUM(CASE WHEN CustomerID IS NULL OR CustomerName IS NULL
        OR Segment IS NULL THEN 1 ELSE 0 END) AS CustomerIssues,
    SUM(CASE WHEN ProductID IS NULL OR ProductName IS NULL
        OR Category IS NULL OR SubCategory IS NULL
        THEN 1 ELSE 0 END) AS ProductIssues,
    SUM(CASE WHEN Country IS NULL OR State IS NULL OR City IS NULL
        OR PostalCode IS NULL OR Region IS NULL
        THEN 1 ELSE 0 END) AS LocationIssues,
    SUM(CASE WHEN ShipMode IS NULL THEN 1 ELSE 0 END) AS ShipModeIssues
FROM silver.superstore_clean;