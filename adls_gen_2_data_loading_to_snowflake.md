* Created the table structure on Snowflake AZURE_SOURCE_DATA_SCHEMA that was supposed to be loaded to ADLS Gen2

* Created the storage integration between snowflake and Data Lake Gen2. Provided the Tenant ID, and storage container path

CREATE STORAGE INTEGRATION azure_storage_int
TYPE=EXTERNAL_STAGE
storage_provider= AZURE
ENABLED=TRUE
azure_tenant_id='42ce94cf-c8c5-4aa3-a75f-bced38e34883'
storage_allowed_locations=('azure://czechoslovakiabankdata.blob.core.windows.net/bank-data/');

* After creation, clicked on the AZURE_CONSENT_URL to provide the storage access

![image](https://github.com/user-attachments/assets/21c9774b-f7c4-49f0-bcfd-a96883e30d00)

* Created a CSV file format for staging, as the source files were in CSV format

CREATE FILE FORMAT azure_storage_file_format
type='csv'
compression='none'
field_delimiter=','
field_optionally_enclosed_by='none'
skip_header=1;

* Landed the data from the gen2 to adls_gen2_stage in Snowflake

![image](https://github.com/user-attachments/assets/d53b149b-c26d-4916-898b-6f9313798d51)

* Created Snowpipes for auto-ingesting data from S3 to the corresponding Snowflake tables

CREATE PIPE client_tbl_snowpipe
AS
COPY INTO BANKING_DATA.AZURE_SOURCE_DATA_SCHEMA.CLIENT_TBL
FROM @adls_gen2_stage/client/
FILE_FORMAT = azure_storage_file_format;

CREATE PIPE disposition_tbl_snowpipe
AS
COPY INTO BANKING_DATA.AZURE_SOURCE_DATA_SCHEMA.DISPOSITION_TBL
FROM @adls_gen2_stage/disposition/
FILE_FORMAT = azure_storage_file_format;

CREATE PIPE card_tbl_snowpipe
AS
COPY INTO BANKING_DATA.AZURE_SOURCE_DATA_SCHEMA.CARD_TBL
FROM @adls_gen2_stage/card/
FILE_FORMAT = azure_storage_file_format;

* Last checked the whether the data have reached the table or not
