--analyzing bornze.erp_loc_a101  to filter unnecessary

SELECT 
REPLACE(cid, '-', '') cid,
cntry
FROM bronze.erp_loc_a101;

--Data standardization and consistency

select DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry

-- there are lot of uneven data so we need to filter it 
SELECT DISTINCT
cntry AS old_cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ( 'US', 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101
ORDER BY cntry
