 -- File     : scripts/bronze/01_ddl_bronze_table.sql
 -- Layer    : Bronze
 -- Purpose  : Create the raw table, then import the Excel file into it (manual step)
 -- Run order: 2
-------------------------------------------------------------------
USE Central_Superstore;
GO
-- Bronze layer: stores raw data as imported from the source file
-- The table below has the same columns and types that the SSMS "Import Data" wizard gives to an Excel sheet.
CREATE TABLE [bronze].[superstore_raw] (
[Row ID] float,
[Order ID] nvarchar(255),
[Order Date] datetime,
[Ship Date] datetime,
[Ship Mode] nvarchar(255),
[Customer ID] nvarchar(255),
[Customer Name] nvarchar(255),
[Segment] nvarchar(255),
[Country] nvarchar(255),
[City] nvarchar(255),
[State] nvarchar(255),
[Postal Code] float,
[Region] nvarchar(255),
[Product ID] nvarchar(255),
[Category] nvarchar(255),
[Sub-Category] nvarchar(255),
[Product Name] nvarchar(255),
[Sales] float,
[Quantity] float,
[Discount] float,
[Profit] float
)
GO
-------------------------------------------------------------------
-- MANUAL STEP: import Central_Superstore.xlsx into bronze.superstore_raw
-- SSMS: right-click the database > Tasks > Import Data
--		Source      : Microsoft Excel  (file Central_Superstore.xlsx, sheet "Central_Region$")
--		Destination : SQL Server, database Central_Superstore
--		Mappings    : choose the EXISTING table [bronze].[superstore_raw]
-- Then continue with the checks in the next file. Expected: 5108 rows.