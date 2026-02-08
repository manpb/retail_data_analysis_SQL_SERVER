DELETE FROM dw.fact_sales;

DELETE FROM dw.dim_customer;
DELETE FROM dw.dim_item;
DELETE FROM dw.dim_store;
DELETE FROM dw.dim_time;
DELETE FROM dw.dim_trans;

--finding tables with invalid data formats
SELECT
    TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'stg'
  AND TABLE_NAME IN ('fact_table','item_dim')
  AND COLUMN_NAME IN ('quantity','unit_price','total_price','unit_price')
ORDER BY TABLE_NAME, COLUMN_NAME;

--rows with invalid data
SELECT TOP 50 item_key, unit_price
FROM stg.item_dim
WHERE unit_price IS NOT NULL
  AND TRY_CONVERT(decimal(18,4), REPLACE(LTRIM(RTRIM(unit_price)), ',', '.')) IS NULL;

--quantifying the problem 
SELECT
  COUNT(*) AS total_items,
  SUM(CASE WHEN TRY_CONVERT(decimal(18,4), REPLACE(LTRIM(RTRIM(unit_price)), ',', '.')) IS NULL
            AND NULLIF(LTRIM(RTRIM(unit_price)), '') IS NOT NULL
           THEN 1 ELSE 0 END) AS invalid_price_rows
FROM stg.item_dim;

--creating the reject table
IF OBJECT_ID('stg.item_dim_price_rejects', 'U') IS NOT NULL
    DROP TABLE stg.item_dim_price_rejects;
GO

SELECT
    item_key,
    item_name,
    unit_price AS unit_price_raw
INTO stg.item_dim_price_rejects
FROM stg.item_dim
WHERE TRY_CONVERT(decimal(18,4), REPLACE(LTRIM(RTRIM(unit_price)), ',', '.')) IS NULL
  AND NULLIF(LTRIM(RTRIM(unit_price)), '') IS NOT NULL;
GO

SELECT * FROM stg.item_dim_price_rejects;

--cleaning invalid data
CREATE OR ALTER VIEW stg.v_item_dim_clean AS
SELECT
    LTRIM(RTRIM(item_key)) AS item_key,
    NULLIF(LTRIM(RTRIM(item_name)), '') AS item_name,
    NULLIF(LTRIM(RTRIM([desc])), '') AS item_desc,

    CASE
      WHEN TRY_CONVERT(decimal(18,4), REPLACE(LTRIM(RTRIM(unit_price)), ',', '.')) IS NOT NULL
      THEN TRY_CONVERT(decimal(18,4), REPLACE(LTRIM(RTRIM(unit_price)), ',', '.'))
      ELSE NULL
    END AS unit_price,

    UPPER(NULLIF(LTRIM(RTRIM(man_country)), '')) AS man_country,
    NULLIF(LTRIM(RTRIM(supplier)), '') AS supplier,
    LOWER(NULLIF(LTRIM(RTRIM(unit)), '')) AS unit
FROM stg.item_dim;
GO