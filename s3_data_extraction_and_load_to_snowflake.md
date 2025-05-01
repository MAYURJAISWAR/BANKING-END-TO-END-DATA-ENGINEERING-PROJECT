* Created the required table structures in Snowflake to hold data fetched from the S3 bucket

* Created a storage integration in Snowflake to connect to the AWS S3 bucket

CREATE STORAGE INTEGRATION aws_s3_integration 
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::183295428453:role/bank_data_access_role'
STORAGE_ALLOWED_LOCATIONS = ('s3://czechoslovakia-banking-data/');

* Verified whether the storage integration was successfully created

DESC INTEGRATION aws_s3_integration;

![image](https://github.com/user-attachments/assets/0c627781-e3eb-49be-bcc7-0ad98b1d3685)


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

![image](https://github.com/user-attachments/assets/b2c0b091-d2d5-4316-a6ea-ac8cad12680a)


* Created Snowpipes for auto-ingesting data from S3 to the corresponding Snowflake tables

CREATE PIPE district_tbl_snowpipe
AUTO_INGEST = TRUE
AS 
COPY INTO BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.TRANSACTION_TBL
FROM '@s3_data_stage/transaction/'
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

SELECT COUNT(*) AS district_tbl_records
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.DISTRICT_TBL;

SELECT COUNT(*) AS account_tbl_records
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ACCOUNT_TBL;

SELECT COUNT(*) AS order_tbl_records
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.ORDER_TBL;

SELECT COUNT(*) AS loan_tbl_records
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.LOAN_TBL;

SELECT COUNT(*) AS transaction_tbl_records
FROM BANKING_DATA.AWS_SOURCE_DATA_SCHEMA.TRANSACTION_TBL;
