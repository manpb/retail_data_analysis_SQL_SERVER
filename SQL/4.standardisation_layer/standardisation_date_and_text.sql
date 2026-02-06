--time parsing
CREATE OR ALTER VIEW stg.v_time_dim_clean AS
SELECT
	time_key,
	TRY_CONVERT(datetime2(0), [date], 103) AS datetime_value,
	[hour],
	[day],
	[week],
	[month],
	[quarter],
	[year]
FROM stg.time_dim;
GO

SELECT COUNT(*) AS bad_rows
FROM stg.v_time_dim_clean
WHERE datetime_value IS NULL;
GO

--trim/standardise text dims

CREATE OR ALTER VIEW stg.v_customer_dim_clean AS
SELECT
    customer_key,
    NULLIF(LTRIM(RTRIM(name)), '') AS customer_name,
    NULLIF(LTRIM(RTRIM(contact_no)), '') AS contact_no,
    NULLIF(LTRIM(RTRIM(nid)), '') AS nid
FROM stg.customer_dim;
GO

CREATE OR ALTER VIEW stg.v_item_dim_clean AS
SELECT
    item_key,
    NULLIF(LTRIM(RTRIM(item_name)), '') AS item_name,
    NULLIF(LTRIM(RTRIM([desc])), '') AS item_desc,
    unit_price,
    UPPER(LTRIM(RTRIM(man_country))) AS man_country,
    NULLIF(LTRIM(RTRIM(supplier)), '') AS supplier,
    LOWER(LTRIM(RTRIM(unit))) AS unit
FROM stg.item_dim;
GO

CREATE OR ALTER VIEW stg.v_store_dim_clean AS
SELECT
    store_key,
    UPPER(LTRIM(RTRIM(division))) AS division,
    UPPER(LTRIM(RTRIM(district))) AS district,
    UPPER(LTRIM(RTRIM(upazila)))  AS upazila
FROM stg.store_dim;
GO

CREATE OR ALTER VIEW stg.v_trans_dim_clean AS
SELECT
    payment_key,
    LOWER(LTRIM(RTRIM(trans_type))) AS trans_type,
    NULLIF(LTRIM(RTRIM(bank_name)), '') AS bank_name
FROM stg.trans_dim;
GO

