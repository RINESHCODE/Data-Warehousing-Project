/*
===================================================================
Stored Procedure : Load Bronze Layer (Source --> Bronze )
===================================================================
Script Purpose :
    This Stored Procedure Loads data into the bronze schema form external CSV file.
    It performs the following actions:
   - Truncate the Bronze table before loading data.
   - Uses the'BULKU INSERT' command to load data from CSV files to bronze tables.
Parameters :
  NONE

Usage Examples:
EXCE bronze.load_bronze;
/*

CREATE OR ALTER PROCEDURE bronze.load_bronze as 

BEGIN
      DECLARE @start_time DATETIME ,@end_time DATETIME ;
	   

	   BEGIN TRY
		 PRINT'======================================================'
		 PRINT'Loading Bronze Layer ';
		 PRINT'======================================================'

		 PRINT'------------------------------------------------------'
		 PRINT'Loading CRM Tables ';
		 PRINT'------------------------------------------------------'
		
		SET @start_time = GETDATE();
		
		PRINT'>>  Tuncating Table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>> Inserting data into : bronze.crm_cust_info '
		BULK INSERT bronze.crm_cust_info 
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' +CAST(DATEDIFF (SECOND, @start_time, @end_time) AS NVARCHAR ) + '  SECONDS'


		SET @start_time = GETDATE()

		PRINT'>>  Tuncating Table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>> Inserting data into : bronze.crm_prd_info ';

		BULK INSERT bronze.crm_prd_info 
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE(); 
		PRINT'>> LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + '  SECONDS'

		SET @start_time = GETDATE();
		PRINT'>>  Tuncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>> Inserting data into :  bronze.crm_sales_details '
		BULK INSERT bronze.crm_sales_details
	
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE(); 
		PRINT'>> LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + '  SECONDS'


		 PRINT'------------------------------------------------------'
		 PRINT'Loading ERP Tables ';
		 PRINT'------------------------------------------------------'
		 
		 SET @start_time = GETDATE();
		 
		 PRINT'>>  Tuncating Table :bronze.erp_cust_az12;';
		TRUNCATE TABLE  bronze.erp_cust_az12;

		PRINT'>> Inserting data into : bronze.erp_cust_az12 '

		BULK INSERT bronze.erp_cust_az12
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE(); 
		PRINT'>> LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + '  SECONDS'

		SET @start_time = GETDATE();

			 PRINT'>>  Tuncating Table :bronze.erp_loc_a101';
		TRUNCATE TABLE  bronze.erp_loc_a101;
			PRINT'>> Inserting data into : bronze.erp_loc_a101 '

		BULK INSERT bronze.erp_loc_a101
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE(); 
		PRINT'>> LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + '  SECONDS'

		SET @start_time = GETDATE();
		PRINT'>>  Tuncating Table :erp_px_cat_g1v2';

		TRUNCATE TABLE  bronze.erp_px_cat_g1v2;
		PRINT'>> Inserting data into :bronze.erp_px_cat_g1v2 ';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM  'C:\Users\rines\OneDrive\Desktop\sql\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',',
			TABLOCK
			)
        SET @end_time = GETDATE(); 
		PRINT'>> LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'

		PRINT'==============================================================='
		PRINT'END OF THE STATEMENT '
		PRINT'==============================================================='
		
	END TRY
	BEGIN CATCH 
     PRINT'========================================================='
	 PRINT'AN ERROR OCCURED DURING THE LODAING THE BRONZE LAYER'
	 PRINT'ERROR MESSAGE: ' + ERROR_MESSAGE();
	 PRINT('ERROR MESSAGE:'+ CAST (ERROR_MESSAGE()AS NVARCHAR))
	 PRINT('ERROR MEAAGE :'+ CAST (ERROR_STATE() AS NVARCHAR))
	 PRINT'========================================================='
	END CATCH



END
