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

SELECT
	item_key,
	COUNT(*) AS count
FROM stg.item_dim
GROUP BY item_key
HAVING COUNT(*)>1;
	
SELECT
	store_key,
	COUNT(*) AS count
FROM stg.store_dim
GROUP BY store_key
HAVING COUNT(*)>1;

SELECT
	time_key,
	COUNT(*) AS count
FROM stg.time_dim
GROUP BY time_key
HAVING COUNT(*)>1;

SELECT
	payment_key,
	COUNT(*) AS count
FROM stg.trans_dim
GROUP BY payment_key
HAVING COUNT(*)>1;


--orphan keys in the fact table(referntial integrity issues)

SELECT TOP 50
	f.customer_key
FROM stg.fact_table f
LEFT JOIN stg.customer_dim c
ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

SELECT TOP 50
	f.item_key
FROM stg.fact_table f
LEFT JOIN stg.item_dim i
ON f.item_key = i.item_key
WHERE i.item_key IS NULL;

SELECT TOP 50
	f.store_key
FROM stg.fact_table f
LEFT JOIN stg.store_dim s
ON f.store_key = s.store_key
WHERE s.store_key IS NULL;

SELECT TOP 50
	f.time_key
FROM stg.fact_table f
LEFT JOIN stg.time_dim t
ON f.time_key = t.time_key
WHERE t.time_key IS  NULL;

SELECT TOP 50
	f.payment_key
FROM stg.fact_table f
LEFT JOIN stg.trans_dim t
ON f.payment_key = t.payment_key
WHERE t.payment_key IS NULL;