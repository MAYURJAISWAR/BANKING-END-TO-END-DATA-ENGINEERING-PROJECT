![image](https://github.com/user-attachments/assets/3fba0c4d-003d-4a18-9a6a-bbf3927c7c58)# BANKING-END-TO-END-DATA-ENGINEERING-PROJECT

**Introduction**:
Creating and implementing a modern ELT pipeline for the bank. This includes extracting, loading, and transforming data from AWS S3 and Azure Data Lake Storage Gen2 into a centralized Snowflake data warehouse, performing transformations with DBT, and ensuring its maintenance across various cross-functional departments.



Project Architecture

![image](https://github.com/user-attachments/assets/36095a92-64c2-4b14-98c9-314bb8400345)


**Tools & Technologies Used**
1. Programming language: SQL
2. Cloud Storage: AWS S3, and Azure Data Lake Storage Gen2 (ADLS Gen2)
3. Data Warehouse: Snowflake
4. Transformation Tool: DBT

**Data Modelling** 

![image](https://github.com/user-attachments/assets/23c54676-dbf4-4370-8334-7b69e1b84526)


**Steps Followed**

**Step 1: Data Extraction**

* Created an automated, and continuous data integration from 2 cloud storage sources
  * AWS S3 -> Snowflake (AWS_SOURCE_DATA_SCHEMA)
  * ADLS GEN2 -> Snowflake (AZURE_SOURCE_DATA_SCHEMA)

  AWS_SOURCE_DATA_SCHEMA Data load

* Created the required table structures in Snowflake under AWS_SOURCE_DATA_SCHEMA to hold data fetched from the S3 bucket

  CREATE TABLE district_tbl (
  a1 INT PRIMARY KEY,
  a2 VARCHAR(100),
  a3 VARCHAR(100),
  a4 INT,
  a5 INT,
  a6 INT,
  a7 INT,
  a8 INT,	
  a9 INT,
  a10 FLOAT,
  a11 INT,
  a12 FLOAT,
  a13 FLOAT,
  a14 INT,
  a15 INT,
  a16 INT
);

CREATE TABLE account_tbl (
  account_id INT PRIMARY KEY,
  district_id INT,
  frequency VARCHAR(40),
  date INT,
  account_type VARCHAR(100)
);

CREATE TABLE order_tbl (
  order_id INT PRIMARY KEY,
  account_id INT,
  bank_to VARCHAR(45),
  account_to INT,
  amount FLOAT
);

CREATE TABLE loan_tbl (
  loan_id INT,
  account_id INT,
  date INT,
  amount INT,
  duration INT,
  payment INT,
  status VARCHAR(35)
);

CREATE TABLE transaction_tbl (
  trans_id INT,
  account_id INT,
  date DATE,
  type VARCHAR(30),
  operation VARCHAR(40),
  amount INT,
  balance FLOAT,
  purpose VARCHAR(40),
  bank VARCHAR(45),
  account_partner_id INT
);

*  Created a storage integration in Snowflake to connect to the AWS S3 bucket

CREATE STORAGE INTEGRATION aws_s3_integration 
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::183295428453:role/bank_data_access_role'
STORAGE_ALLOWED_LOCATIONS = ('s3://czechoslovakia-banking-data/');

* Verified whether the storage integration was successfully created

DESC INTEGRATION aws_s3_integration;

![image](https://github.com/user-attachments/assets/52ded14f-4778-4a98-a627-21276ff9d8c4)

* Created a CSV file format for staging, as the source files were in CSV format

CREATE FILE FORMAT aws_s3_file_format
TYPE = 'CSV'
COMPRESSION = 'NONE'
FIELD_DELIMITER = ','
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE'
SKIP_HEADER = 1;

*  Created an external stage to land raw data in a staging location in Snowflake

CREATE STAGE s3_data_stage
URL = 's3://czechoslovakia-banking-data'
FILE_FORMAT = aws_s3_file_format
STORAGE_INTEGRATION = aws_s3_integration;

* Verified whether the stage was created properly

SHOW STAGES;

![image](https://github.com/user-attachments/assets/45375fcd-714f-4af4-8d9f-358c9ef65d9f)


* Created Snowpipes for auto-ingesting data from S3 to the corresponding Snowflake tables:

CREATE PIPE district_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ACCOUNT_TBL
FROM '@s3_data_stage/account/'
FILE_FORMAT = aws_s3_file_format;

CREATE PIPE account_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ACCOUNT_TBL
FROM '@s3_data_stage/account/'
FILE_FORMAT = aws_s3_file_format;

CREATE PIPE order_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ORDER_TBL
FROM '@s3_data_stage/order/'
FILE_FORMAT = aws_s3_file_format;

CREATE PIPE loan_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.LOAN_TBL
FROM '@s3_data_stage/loan/'
FILE_FORMAT = aws_s3_file_format;

CREATE PIPE transaction_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.TRANSACTION_TBL
FROM '@s3_data_stage/transaction/'
FILE_FORMAT = aws_s3_file_format;

* Triggered manual refresh of a pipe to check whether data had reached Snowflake

ALTER PIPE BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.DISTRICT_TBL_SNOWPIPE REFRESH;
ALTER PIPE BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ACCOUNT_TBL_SNOWPIPE REFRESH;
ALTER PIPE BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ORDER_TBL_SNOWPIPE REFRESH;
ALTER PIPE BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.LOAN_TBL_SNOWPIPE REFRESH;
ALTER PIPE BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.TRANSACTION_TBL_SNOWPIPE REFRESH;


* Verified the number of records loaded into the table

SELECT COUNT(*) AS DISTRICT_TBL_TOTAL_RECORDS
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.DISTRICT_TBL;

![image](https://github.com/user-attachments/assets/81eae045-5def-463f-99cb-a6ca650e3547)



SELECT COUNT(*) AS ACCOUNT_TBL_TOTAL_RECORDS
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ACCOUNT_TBL;

![image](https://github.com/user-attachments/assets/6782ec61-b72e-4c8a-b8b5-894bb4f64bc4)



SELECT COUNT(*) AS ORDER_TBL_TOTAL_RECORDS
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ORDER_TBL;

![image](https://github.com/user-attachments/assets/7910abc0-1747-4195-aad7-ce2a0068d1cf)



SELECT COUNT(*) AS LOAN_TBL_TOTAL_RECORDS
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.LOAN_TBL;

![image](https://github.com/user-attachments/assets/d706e44f-1e02-4e86-a478-47908adafc6f)


SELECT COUNT(*) AS TRANSACTION_TBL_TOTAL_RECORDS
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.TRANSACTION_TBL;

![image](https://github.com/user-attachments/assets/af608730-d3df-4f59-826d-e5c22dec51f2)





**Step 2: Raw Data Layering**

* Maintained source-specific schema (AWS_SOURCE_DATA_SCHEMA, and AZURE_SOURCE_DATA_SCHEMA) to separate raw data based on sources to ensure better maintainability

**Step 3: Loading into staging **

* Copied the raw data tables into a different staging schema loading_staging_schema_1 within Snowflake using dbt Core so as to preserve the irst loaded copy

**Step 4: Data Transformation **
* Performed data transformation (converting int to proper date format,changing the column names,establishing constraints like PK, and FK, etc) in DBT core models
* Loaded the clean datasets into separated into TRANSFORMED_DATA_SCHEMA


