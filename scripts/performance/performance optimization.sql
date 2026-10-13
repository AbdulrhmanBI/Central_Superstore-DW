 -- File     : scripts/performance/performance optimization.sql
 -- Layer    : Performance
 -- Purpose  : Indexes
 -- Run order: 11
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- indexes on the foreign-key columns of the fact table
DROP INDEX IF EXISTS IX_FactSales_CustomerKey  ON gold.FactSales;
CREATE INDEX IX_FactSales_CustomerKey  ON gold.FactSales (CustomerKey);
DROP INDEX IF EXISTS IX_FactSales_ProductKey  ON gold.FactSales;
CREATE INDEX IX_FactSales_ProductKey ON gold.FactSales (ProductKey); GO
DROP INDEX IF EXISTS IX_FactSales_LocationKey  ON gold.FactSales;
CREATE INDEX IX_FactSales_LocationKey  ON gold.FactSales (LocationKey);
DROP INDEX IF EXISTS IX_FactSales_ShipModeKey  ON gold.FactSales;
CREATE INDEX IX_FactSales_ShipModeKey  ON gold.FactSales (ShipModeKey);
DROP INDEX IF EXISTS IX_FactSales_OrderDateKey ON gold.FactSales;
CREATE INDEX IX_FactSales_OrderDateKey ON gold.FactSales (OrderDateKey);
DROP INDEX IF EXISTS IX_FactSales_ShipDateKey  ON gold.FactSales;
CREATE INDEX IX_FactSales_ShipDateKey  ON gold.FactSales (ShipDateKey);
GO