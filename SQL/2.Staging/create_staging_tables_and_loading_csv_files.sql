USE RetailDW;
GO
CREATE TABLE stg.fact_table(
	payment_key varchar(20) NULL,
	customer_key varchar(20) NULL,
	time_key varchar(20) NULL,
	item_key  varchar(20) NULL,
	store_key varchar(20) NULL,
	quantity decimal(18,4) NULL,
	unit varchar(20) NULL,
	unit_price decimal(18,4) NULL,
	total_price decimal(18,4) NULL
	);

CREATE TABLE stg.customer_dim(
	customer_key varchar(20) NULL,
    name         varchar(200) NULL,
    contact_no   varchar(50) NULL,
    nid          varchar(50) NULL
	);

CREATE TABLE stg.item_dim (
    item_key     varchar(20) NULL,
    item_name    varchar(255) NULL,
    [desc]       varchar(255) NULL,
    unit_price   decimal(18,4) NULL,
    man_country  varchar(100) NULL,
    supplier     varchar(255) NULL,
    unit         varchar(50) NULL
);

CREATE TABLE stg.store_dim (
    store_key varchar(20) NULL,
    division  varchar(100) NULL,
    district  varchar(100) NULL,
    upazila   varchar(100) NULL
);

CREATE TABLE stg.time_dim (
    time_key varchar(20) NULL,
    [date]   varchar(50) NULL,  
    [hour]   int NULL,
    [day]    int NULL,
    [week]   varchar(20) NULL,
    [month]  int NULL,
    [quarter] varchar(10) NULL,
    [year]   int NULL
);

CREATE TABLE stg.trans_dim (
    payment_key varchar(20) NULL,
    trans_type  varchar(20) NULL,
    bank_name   varchar(255) NULL
);

BULK INSERT stg.fact_table
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\fact_table.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

BULK INSERT stg.customer_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\customer_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

BULK INSERT stg.item_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\item_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

DROP TABLE IF EXISTS stg.item_dim;
GO

CREATE TABLE stg.item_dim(
    item_key     varchar(100) NULL,
    item_name    varchar(100) NULL,
    [desc]       varchar(100) NULL,
    unit_price   varchar(100) NULL,
    man_country  varchar(100) NULL,
    supplier     varchar(100) NULL,
    unit         varchar(100) NULL
);
GO

BULK INSERT stg.item_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\item_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

BULK INSERT stg.store_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\store_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

BULK INSERT stg.time_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\time_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

BULK INSERT stg.trans_dim
FROM 'D:\Studies\Projects\SQL Projects\SQL Server Projects\Retail Data Analysis\Data Files\trans_dim.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a',
	TABLOCK,
	KEEPNULLS
	);

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