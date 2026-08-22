--unable to find any unmatching cust info from erp and crm
--to validate the filter put silver. instead of bronze. on quarry
SELECT
cid,
CASE 
	When cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(CID))
	 ELSE cid
   END AS cid,
bdate,
gen
FROM bronze.erp_cust_az12
WHERE 
Case When cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(CID))
	 ELSE cid
END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)


--next column bdate
SELECT 
CASE 
	When cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(CID))
	 ELSE cid
   END AS cid, 
CASE WHen bdate > GETDATE() THEN NULL
	 ELSE bdate
END AS bdate,
gen
FROM bronze.erp_cust_az12

--next gendre
SELECT 
CASE 
	When cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(CID))
	 ELSE cid
   END AS cid, 
CASE WHen bdate > GETDATE() THEN NULL
	 ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12
