SELECT
sd.sls_ord_num,
sd.sls_prd_key,
sd.sls_cust_id,
sd.sls_order_dt,
sd.sls_ship_dt,
sd.sls_due_dt,
sd.sls_sales,
sd.sls_quantity,
sd.sls_price
FROM silver.crm_sales_details sd

-- dimension vs facts 
-- we have lot of ids, key and dates so its facts
-- now have to built the dimensions using dimension's surrogate keys instead of ids to easily connect
-- in selver layer we don't have any surrogate key so going to join with gold layer
SELECT
sd.sls_ord_num,
pr.product_key,     -- we no more need prd_key from sales details but our own surrogate key we generated ourself in datawarehouse
cu.customer_key,      --we no more need sd.sls_cust_id key,
sd.sls_order_dt,
sd.sls_ship_dt,
sd.sls_due_dt,
sd.sls_sales,
sd.sls_quantity,
sd.sls_price
FROM silver.crm_sales_details sd
LEFT JOIN  gold.dim_products pr
On sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id

-- those two pr.product_key and cu.customer_key is necessary for building facts table
-- now we have to give them friendly name 

SELECT
sd.sls_ord_num AS order_number,
pr.product_key,     -- we no more need prd_key from sales details but our own surrogate key we generated ourself in datawarehouse
cu.customer_key,      --we no more need sd.sls_cust_id key,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS shipping_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales_amount,
sd.sls_quantity AS quantity,
sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN  gold.dim_products pr
On sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id

-- sort the column into logical gropus to improve readability its already in order

