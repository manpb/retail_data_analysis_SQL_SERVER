
--loading dim tables
INSERT INTO dw.dim_customer (customer_key, customer_name, contact_no, nid)
SELECT customer_key, customer_name, contact_no, nid
FROM stg.v_customer_dim_clean;


INSERT INTO dw.dim_item (item_key, item_name, item_desc, unit_price, man_country, supplier, unit)
SELECT item_key, item_name, item_desc, unit_price, man_country, supplier, unit
FROM stg.v_item_dim_clean;


INSERT INTO dw.dim_store (store_key, division, district, upazila)
SELECT store_key, division, district, upazila
FROM stg.v_store_dim_clean;


INSERT INTO dw.dim_trans (payment_key, trans_type, bank_name)
SELECT payment_key, trans_type, bank_name
FROM stg.v_trans_dim_clean;


INSERT INTO dw.dim_time (time_key, datetime_value, [date], [hour], [day], [week], [month], [quarter], [year])
SELECT
    time_key,
    datetime_value,
    CAST(datetime_value AS date) AS [date],
    [hour], [day], [week], [month], [quarter], [year]
FROM stg.v_time_dim_clean
WHERE datetime_value IS NOT NULL;
GO


--loading fact table
TRUNCATE TABLE dw.fact_sales;

INSERT INTO dw.fact_sales
(payment_key, customer_key, time_key, item_key, store_key, quantity, unit, unit_price, total_price)
SELECT
    payment_key,
    customer_key,
    time_key,
    item_key,
    store_key,
    quantity,
    LOWER(LTRIM(RTRIM(unit))) AS unit,
    unit_price,
    total_price
FROM stg.fact_table;
GO

--post load reconicilliation
SELECT
    (SELECT COUNT(*) FROM stg.fact_table) AS stg_rows,
    (SELECT COUNT(*) FROM dw.fact_sales)  AS dw_rows;

SELECT
    (SELECT SUM(total_price) FROM stg.fact_table) AS stg_total_sales,
    (SELECT SUM(total_price) FROM dw.fact_sales)  AS dw_total_sales;