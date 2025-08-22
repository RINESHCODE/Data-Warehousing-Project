/*
=====================================
Create DataBase and Schema 
=====================================
Script Purpose :
    This Scripts creates a new database name'DataWarehousing' after checking it it already exhists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this scipts.

*/








USE master;
GO

IF EXIST (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')

BEGIN 
   ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
   DROP DATABASE DataWarehouse;

END;
GO 


CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO


Create SCHEMA bronze;
GO

Create SCHEMA silver;
go
 
Create SCHEMA gold;
go
