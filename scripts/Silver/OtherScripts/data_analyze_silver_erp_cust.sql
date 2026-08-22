SELECT
cid,
bdate,
gen
FROM bronze.erp_cust_az12

--next column bdate
SELECT DISTINCT
bdate 
from bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

--next is gender column
--Data standardization and consistency
select DISTINCT gen
from bronze.erp_cust_az12