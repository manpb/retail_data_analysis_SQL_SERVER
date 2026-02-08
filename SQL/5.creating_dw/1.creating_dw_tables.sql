-- Dimensions
CREATE TABLE dw.dim_customer (
    customer_key varchar(20) NOT NULL PRIMARY KEY,
    customer_name varchar(200) NULL,
    contact_no varchar(50) NULL,
    nid varchar(50) NULL
);

CREATE TABLE dw.dim_item (
    item_key varchar(20) NOT NULL PRIMARY KEY,
    item_name varchar(255) NULL,
    item_desc varchar(255) NULL,
    unit_price decimal(18,4) NULL,
    man_country varchar(100) NULL,
    supplier varchar(255) NULL,
    unit varchar(50) NULL
);

CREATE TABLE dw.dim_store (
    store_key varchar(20) NOT NULL PRIMARY KEY,
    division varchar(100) NULL,
    district varchar(100) NULL,
    upazila varchar(100) NULL
);

CREATE TABLE dw.dim_time (
    time_key varchar(20) NOT NULL PRIMARY KEY,
    datetime_value datetime2(0) NOT NULL,
    [date] date NOT NULL,
    [hour] int NULL,
    [day] int NULL,
    [week] varchar(20) NULL,
    [month] int NULL,
    [quarter] varchar(10) NULL,
    [year] int NULL
);

CREATE TABLE dw.dim_trans (
    payment_key varchar(20) NOT NULL PRIMARY KEY,
    trans_type varchar(20) NULL,
    bank_name varchar(255) NULL
);

-- Fact
CREATE TABLE dw.fact_sales (
    payment_key  varchar(20) NOT NULL,
    customer_key varchar(20) NOT NULL,
    time_key     varchar(20) NOT NULL,
    item_key     varchar(20) NOT NULL,
    store_key    varchar(20) NOT NULL,
    quantity     decimal(18,4) NULL,
    unit         varchar(50) NULL,
    unit_price   decimal(18,4) NULL,
    total_price  decimal(18,4) NULL,
    CONSTRAINT PK_fact_sales PRIMARY KEY (payment_key, item_key, time_key, store_key, customer_key),
    CONSTRAINT FK_fact_customer FOREIGN KEY (customer_key) REFERENCES dw.dim_customer(customer_key),
    CONSTRAINT FK_fact_item     FOREIGN KEY (item_key)     REFERENCES dw.dim_item(item_key),
    CONSTRAINT FK_fact_store    FOREIGN KEY (store_key)    REFERENCES dw.dim_store(store_key),
    CONSTRAINT FK_fact_time     FOREIGN KEY (time_key)     REFERENCES dw.dim_time(time_key),
    CONSTRAINT FK_fact_trans    FOREIGN KEY (payment_key)  REFERENCES dw.dim_trans(payment_key)
);
GO

-- Helpful indexes for BI
CREATE INDEX IX_fact_time     ON dw.fact_sales(time_key);
CREATE INDEX IX_fact_item     ON dw.fact_sales(item_key);
CREATE INDEX IX_fact_store    ON dw.fact_sales(store_key);
CREATE INDEX IX_fact_customer ON dw.fact_sales(customer_key);
CREATE INDEX IX_fact_payment  ON dw.fact_sales(payment_key);
GO
