-- creates store procedure use 'EXEC bronze.load_bronze' to execute this stored procedure 
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	--Truncate emties the table before we bulk insert
		SET @batch_start_time = GETDATE();
		PRINT '=================================================================================================';
		PRINT 'Loading Bronze Layer'
		PRINT '=================================================================================================';

		PRINT '-------------------------------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------------------------------------------------------';

		SET @start_time = getdate();
		PRINT '>> Truncating Table: bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Insurting Data Into: bronze.crm_cust_info ';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @start_time = getdate();
		PRINT '>> Truncating Table: bronze.crm_prd_info ';	
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Insurting Table: bronze.crm_prd_info ';	
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @start_time = getdate();
		PRINT '>> Truncating Table: bronze.crm_sales_details ';	
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Insurting Data Into Table: bronze.crm_sales_details ';	
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @start_time = getdate();

	
		PRINT '-------------------------------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------------------------------------------------------';
		PRINT '>> Truncating Table: bronze.erp_loc_a101';	
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Insurting Data Into Table: bronze.erp_loc_a101';	
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @start_time = getdate();

		PRINT '>> Truncating Table: bronze.erp_cust_az12';	
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Insurting Data Into Table: bronze.erp_cust_az12';	
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @start_time = getdate();

		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';	
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Insurting Data Into Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ShresthA\Downloads\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>------------------';

		SET @batch_end_time = GETDATE();
		PRINT '=================================================================================================';
		PRINT 'lOADING BRONZE LAYER IS COMPLETE';
		PRINT ' - Total Load Durataion: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=================================================================================================';

	END TRY
	BEGIN CATCH
		PRINT '===============================================================================================';
		PRINT 'Error OCCURED dURING lOADING BRONZE LAYER';
		PRINT 'Error Mesage' + ERROR_MESSAGE();
		PRINT 'Error Mesage' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Mesage' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===============================================================================================';
	END CATCH
END


-- SELECT * FROM bronze.crm_cust_info
-- SELECT COUNT(*) FROM bronze.crm_cust_info
