
/*Create Database and Schemas
Script Purpose
this script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database : bronze, 'silver', and 'gold'

WARNING:
Running this script will drop the entire 'DataWarehouse' database if exists.
All Data in the database will be permanently deleted. Proceed with caution and 
ensure you have proper backups before running this script.
*/

USE master;

GO

--Drop and recreate the 'DataWarehouse' database

IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'dataWarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

--Create the 'DataWarehouse' database

CREATE Database DataWarehouse;
GO

use DataWarehouse;

--Create Schemas
CREATE SCHEMA bronze;
GO                          -- GO is like seperator 
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
