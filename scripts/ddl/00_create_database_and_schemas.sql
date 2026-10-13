 -- File     : scripts/ddl/00_create_database_and_schemas.sql
 -- Layer    : Init
 -- Purpose  : Create the database and the bronze / silver / gold schemas
 -- Run order: 1
-------------------------------------------------------------------
-- Create database
CREATE DATABASE Central_Superstore;
GO
USE Central_Superstore;
GO
-- Create the three layers (schemas)
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
