USE RetailDW;

SELECT TOP 5 *
FROM stg.customer_dim;

SELECT TOP 5 *
FROM stg.fact_table;

SELECT TOP 5 *
FROM stg.item_dim;

SELECT TOP 5 *
FROM stg.store_dim;

SELECT TOP 5 *
FROM stg.time_dim;

SELECT TOP 5 * 
FROM stg.trans_dim;

--no of records in each table
SELECT 'fact_table' AS table_name, COUNT(*) AS rows_count FROM stg.fact_table
UNION ALL SELECT 'customer_dim', COUNT(*) FROM stg.customer_dim
UNION ALL SELECT 'item_dim', COUNT(*) FROM stg.item_dim
UNION ALL SELECT 'store_dim', COUNT(*) FROM stg.store_dim
UNION ALL SELECT 'time_dim', COUNT(*) FROM stg.time_dim
UNION ALL SELECT 'trans_dim', COUNT(*) FROM stg.trans_dim;

--duplicate key checks
SELECT 
	customer_key,
	COUNT(*) AS count
FROM stg.customer_dim
GROUP BY customer_key
HAVING COUNT(*)>1;


