 -- File     : scripts/bronze/02_bronze_checks.sql
 -- Layer    : Bronze
 -- Purpose  : Row count, preview, missing values and duplicates in the raw data
 -- Run order: 3
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Check the total number of rows imported into Bronze
SELECT COUNT(*) AS TotalRows
FROM bronze.superstore_raw;
-- Preview first 10 rows
SELECT TOP 10 *
FROM bronze.superstore_raw;
-- Check data quality in Bronze
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN [Row ID] IS NULL THEN 1 ELSE 0 END) AS MissingRowID,
    SUM(CASE WHEN [Order ID] IS NULL THEN 1 ELSE 0 END) AS MissingOrderID,
    SUM(CASE WHEN [Customer ID] IS NULL THEN 1 ELSE 0 END) AS MissingCustomerID,
    SUM(CASE WHEN [Product ID] IS NULL THEN 1 ELSE 0 END) AS MissingProductID,
    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS MissingSales
FROM bronze.superstore_raw;
-- Count unique rows
SELECT COUNT(*) AS UniqueRows
FROM (
    SELECT DISTINCT *
    FROM bronze.superstore_raw
) AS B;
