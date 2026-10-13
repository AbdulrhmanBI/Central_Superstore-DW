 -- File     : scripts/gold/04_view_vw_sales.sql
 -- Layer    : Gold
 -- Purpose  : View gold.vw_Sales: the whole star schema flattened in one table (for reports / Power BI)
 -- Run order: 9
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Create a sales analysis view
CREATE OR ALTER VIEW gold.vw_Sales
AS
SELECT
    F.SalesKey,
    F.OrderID,
    C.CustomerID,
    C.CustomerName,
    C.Segment,
    P.ProductID,
    P.ProductName,
    P.Category,
    P.SubCategory,
    L.Country,
    L.StateName,
    L.City,
    L.Region,
    SM.ShipMode,
    OD.FullDate AS OrderDate,
    OD.YearNumber AS OrderYear,
    OD.MonthNumber AS OrderMonth,
    OD.MonthName AS OrderMonthName,
    OD.QuarterNumber AS OrderQuarter,
    SD.FullDate AS ShipDate,
    F.Sales,
    F.Quantity,
    F.Discount,
    F.Profit,
    F.ShippingDays,
    -- Profit margin
    round(F.Profit / F.Sales * 100, 2) AS ProfitMarginPct,
    -- Discount classification
    CASE
        WHEN F.Discount = 0 THEN 'No Discount'
        WHEN F.Discount <= 0.20 THEN 'Low'
        WHEN F.Discount <= 0.50 THEN 'Medium'
        ELSE 'High'
    END AS DiscountBand,
    -- duration classification
    CASE
        WHEN F.ShippingDays < 0 THEN 'Invalid'
        WHEN F.ShippingDays <= 2 THEN 'Quick'
        WHEN F.ShippingDays <= 5 THEN 'Standard'
        ELSE 'Long'
    END AS DurationBand
FROM gold.FactSales AS F
INNER JOIN gold.DimCustomer AS C
    ON F.CustomerKey = C.CustomerKey
INNER JOIN gold.DimProduct AS P
    ON F.ProductKey = P.ProductKey
INNER JOIN gold.DimLocation AS L
    ON F.LocationKey = L.LocationKey
INNER JOIN gold.DimShipMode AS SM
    ON F.ShipModeKey = SM.ShipModeKey
INNER JOIN gold.DimDate AS OD
    ON F.OrderDateKey = OD.DateKey
INNER JOIN gold.DimDate AS SD
    ON F.ShipDateKey = SD.DateKey;
GO
-- Preview the view
SELECT TOP 10 *
FROM gold.vw_Sales;
SELECT
    Category,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM gold.vw_Sales
GROUP BY Category;
GO
