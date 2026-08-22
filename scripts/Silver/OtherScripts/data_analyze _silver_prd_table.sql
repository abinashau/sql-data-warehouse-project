--check For Nulls or Duplicates in Primary Key of Prduct Table 
-- Expectation: No Result
SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 or prd_id IS NULL

--check for unwanted space in product_nm
--Expectation: No Result
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--check for NULLs or Negetive Numbers in prd_cost
--Expectation: No Results
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--Data standadization and consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--check for invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt