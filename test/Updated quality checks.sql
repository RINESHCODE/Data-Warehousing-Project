/*
=======================================================
Quality Checks 
=======================================================
Script Purpose:
    This script performs various quality checks for data consistency,
accuracy, and standardization across the 'sliver' schema . It includes checks for :
   - Null
   - Unwanted Spaces in string fields 
   - Data standadizaion and consistency.
   - Invalid date ranges and orders .
   - Data consistency between related fields.

Usage Notes :
  - Run these checks after data loading silver layer.
  - investigating and reslove any descrepancies found during the checks. 
=======================================================
*/




SELECT sls_order_num, COUNT(*) FROM silver.crm_sales_details
GROUP BY prd_id
HAVING COUNT(*) > 1 OR  prd_id IS NULL



--Check for Unwanted Spaces 
-- Expectation :no Results

SELECT prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm ! = TRIM(prd_nm)
-- Check for Null or Negative Numbers

SELECT prd_cost FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost Is NULL
-- Data Standerdization & Consistency

SELECT DISTINCT prd_line 
FROM silver.crm_prd_info


--Check for invalid Date Orders
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt


SELECT * FROM silver.crm_prd_info

--Check for Invalid Date
SELECT 
NULLIF(sls_order_dt, 0 ) sls_order_dt
FROM bronze.crm_sales_details
WHERE  sls_order_dt >20500101 OR  sls_order_dt < 19000101

--Check for Invalid Date Orders

SELECT * FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

SELECT 

sls_sales ,
sls_quantity , 


 sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS  NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales IS  NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity  <= 0  OR sls_price  <= 0 
ORDER BY sls_sales,sls_quantity, sls_price


 SELECT DISTINCT 
 bdate FROM bronze < '1924-01-01' OR bdate > GETDATE()


 --Data Standardization & Consistency

SELECT DISTINCT gen ,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
     ELSE 'n/a'
END AS gen 


FROM bronze.erp_cust_az12


