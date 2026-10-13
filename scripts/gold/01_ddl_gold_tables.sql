 -- File     : scripts/gold/01_ddl_gold_tables.sql
 -- Layer    : Gold
 -- Purpose  : Star schema: 5 dimension tables + FactSales with primary / foreign keys
 -- Run order: 6
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Gold layer: stores business-ready data in a star schema for analytics and reporting
-- 1) Customer dimension
CREATE TABLE gold.DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID NVARCHAR(255) NOT NULL UNIQUE,
    CustomerName NVARCHAR(255) NOT NULL,
    Segment NVARCHAR(255) NOT NULL
);
GO
-- 2) Product dimension
CREATE TABLE gold.DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID NVARCHAR(255) NOT NULL,
    ProductName NVARCHAR(255) NOT NULL,
    Category NVARCHAR(255) NOT NULL,
    SubCategory NVARCHAR(255) NOT NULL,
    CONSTRAINT UQ_DimProduct_ProductID_ProductName
        UNIQUE (ProductID, ProductName)
);
GO
-- 3) Location dimension
CREATE TABLE gold.DimLocation (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Country NVARCHAR(255) NOT NULL,
    StateName NVARCHAR(255) NOT NULL,
    City NVARCHAR(255) NOT NULL,
    PostalCode NVARCHAR(255) NOT NULL,
    Region NVARCHAR(255) NOT NULL,
    CONSTRAINT UQ_DimLocation
        UNIQUE (Country, StateName, City, PostalCode, Region)
);
GO
-- 4) Shipping mode dimension
CREATE TABLE gold.DimShipMode (
    ShipModeKey INT IDENTITY(1,1) PRIMARY KEY,
    ShipMode NVARCHAR(255) NOT NULL UNIQUE
);
GO
-- 5) Date dimension
CREATE TABLE gold.DimDate (
    DateKey INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE NOT NULL UNIQUE,
    YearNumber INT NOT NULL,
    QuarterNumber INT NOT NULL,
    MonthNumber INT NOT NULL,
    MonthName NVARCHAR(255) NOT NULL,
    DayNumber INT NOT NULL
);
GO
-- 6) Sales fact table
CREATE TABLE gold.FactSales (
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    OrderID NVARCHAR(255),
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    LocationKey INT NOT NULL,
    ShipModeKey INT NOT NULL,
    OrderDateKey INT,
    ShipDateKey INT,
    Sales DECIMAL(20,5),
    Quantity INT,
    Discount DECIMAL(20,5),
    Profit DECIMAL(20,5),
    ShippingDays INT,
    CONSTRAINT FK_FactSales_Customer
        FOREIGN KEY (CustomerKey)
        REFERENCES gold.DimCustomer(CustomerKey),
    CONSTRAINT FK_FactSales_Product
        FOREIGN KEY (ProductKey)
        REFERENCES gold.DimProduct(ProductKey),
    CONSTRAINT FK_FactSales_Location
        FOREIGN KEY (LocationKey)
        REFERENCES gold.DimLocation(LocationKey),
    CONSTRAINT FK_FactSales_ShipMode
        FOREIGN KEY (ShipModeKey)
        REFERENCES gold.DimShipMode(ShipModeKey),
    CONSTRAINT FK_FactSales_OrderDate
        FOREIGN KEY (OrderDateKey)
        REFERENCES gold.DimDate(DateKey),
    CONSTRAINT FK_FactSales_ShipDate
        FOREIGN KEY (ShipDateKey)
        REFERENCES gold.DimDate(DateKey)
);