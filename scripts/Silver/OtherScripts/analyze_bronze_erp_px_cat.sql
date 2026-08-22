-- analyzing analyze_bronze_erp_px_cat

SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2

--check for unwanted spaces
SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2
where cat!= trim(cat) or subcat != trim(subcat) or maintenance != TRIM(maintenance)

--data standerdization and consisitency
select distinct
cat 
from bronze.erp_px_cat_g1v2


-- this table is really clean so don't need to do anythin just enter to silver layer as it is
