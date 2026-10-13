 -- File     : scripts/analysis/01_analytical_queries.sql
 -- Layer    : Analysis
 -- Purpose  : 16 analytical queries (KPIs, products, customers, shipping, discounts, trends)
 -- Run order: 10
-------------------------------------------------------------------
USE Central_Superstore;
GO
-------------------------------------------------------------------
-- Query 1: Overall KPIs
SELECT
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) / SUM(Sales) * 100.0 AS ProfitMarginPct
FROM gold.FactSales;
-- Query 2: Highest and Lowest Sale
SELECT
    MAX(Sales) AS HighestSale,
    MIN(Sales) AS LowestSale
FROM gold.FactSales;
-- Query 3: Count Orders & Average Sales
SELECT
    COUNT(DISTINCT OrderID) AS TotalOrders,
    SUM(Sales) / COUNT(DISTINCT OrderID) AS AvgOrderValue
FROM gold.FactSales;
-- Query 4: Sales and Profit by Category
SELECT
    P.Category,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimProduct AS P
    ON F.ProductKey = P.ProductKey
GROUP BY P.Category
ORDER BY TotalSales DESC;
-- Query 5: Sales and Profit by Region
SELECT
    L.Region,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimLocation AS L
    ON F.LocationKey = L.LocationKey
GROUP BY L.Region
ORDER BY TotalSales DESC;
-- Query 6: Sales and Profit by Segment
SELECT
    C.Segment,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimCustomer AS C
    ON F.CustomerKey = C.CustomerKey
GROUP BY C.Segment
ORDER BY TotalProfit DESC;
-- Query 7: Sales and Profit by Year
SELECT
    D.YearNumber,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimDate AS D
    ON F.OrderDateKey = D.DateKey
GROUP BY D.YearNumber
ORDER BY D.YearNumber;
-- Query 8: Top 10 Customers by Profit (CTE 1)
WITH CustomerPerformance AS (
    SELECT
        C.CustomerID,
        C.CustomerName,
        SUM(F.Sales) AS TotalSales,
        SUM(F.Profit) AS TotalProfit
    FROM gold.FactSales AS F
    INNER JOIN gold.DimCustomer AS C
        ON F.CustomerKey = C.CustomerKey
    GROUP BY
        C.CustomerID,
        C.CustomerName
)
SELECT TOP 10
    CustomerID,
    CustomerName,
    TotalSales,
    TotalProfit
FROM CustomerPerformance
ORDER BY TotalProfit DESC;
-- Query 9: Top 5 Orders by Sales
SELECT TOP 5
    OrderID,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM gold.FactSales
GROUP BY OrderID
ORDER BY TotalSales DESC;
-- Query 10: Top 5 Products by Sales
SELECT TOP 5
    P.ProductID,
    P.ProductName,
    SUM(F.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimProduct AS P
    ON F.ProductKey = P.ProductKey
GROUP BY
    P.ProductID,
    P.ProductName
ORDER BY TotalSales DESC;
-- Query 11: Top 10 Loss-Making Products
SELECT TOP 10
    P.ProductName,
    P.ProductID,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimProduct AS P
    ON F.ProductKey = P.ProductKey
GROUP BY P.ProductName, P.ProductID
HAVING SUM(F.Profit) < 0
ORDER BY TotalProfit ASC;
-- Query 12: Profit and Loss Analysis
SELECT
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS ProfitStatus,
    COUNT(*) AS SalesLines,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM gold.FactSales
GROUP BY
    CASE
        WHEN Profit > 0 THEN 'Profit'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END;
-- Query 13: Shipping Duration by Ship Mode
SELECT
    SM.ShipMode,
    -- CAST first: AVG of an INT column returns an INT in SQL Server (4.99 would show as 4)
    ROUND(AVG(CAST(F.ShippingDays AS DECIMAL(10,2))), 2) AS AvgShippingDays,
    SUM(F.Sales) AS TotalSales,
    SUM(F.Profit) AS TotalProfit
FROM gold.FactSales AS F
INNER JOIN gold.DimShipMode AS SM
    ON F.ShipModeKey = SM.ShipModeKey
GROUP BY SM.ShipMode
ORDER BY AvgShippingDays DESC;
-- Query 14: Profitability by Discount Level
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low'
        WHEN Discount <= 0.50 THEN 'Medium'
        ELSE 'High'
    END AS DiscountLevel,
    COUNT(*) AS SalesLines,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM gold.FactSales
GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low'
        WHEN Discount <= 0.50 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY TotalProfit DESC;
-- Query 15: Monthly Sales Trend (CTE 2)
WITH MonthlySales AS (
    SELECT
        D.YearNumber,
        D.MonthNumber,
        D.MonthName,
        SUM(F.Sales) AS TotalSales,
        SUM(F.Profit) AS TotalProfit
    FROM gold.FactSales AS F
    INNER JOIN gold.DimDate AS D
        ON F.OrderDateKey = D.DateKey
    GROUP BY
        D.YearNumber,
        D.MonthNumber,
        D.MonthName
)
SELECT
    YearNumber,
    MonthNumber,
    MonthName,
    TotalSales,
    TotalProfit
FROM MonthlySales
ORDER BY YearNumber, MonthNumber;
-- Query 16: Products with Above-Average Profit (compared with the average product)
SELECT
    ProductID,
    ProductName,
    SUM(Profit) AS TotalProfit
FROM gold.vw_Sales
GROUP BY
    ProductID,
    ProductName
HAVING SUM(Profit) > (
    -- the average of the PRODUCT totals (not the average of one sales line)
    SELECT AVG(ProductProfit)
    FROM (
        SELECT SUM(Profit) AS ProductProfit
        FROM gold.vw_Sales
        GROUP BY ProductID, ProductName
    ) AS ProductTotals
)
ORDER BY TotalProfit DESC;
