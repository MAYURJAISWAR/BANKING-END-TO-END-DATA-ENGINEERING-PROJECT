# BANKING-END-TO-END-DATA-ENGINEERING-PROJECT

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



**Step 2: Raw Data Layering**

* Maintained source-specific schema (AWS_SOURCE_DATA_SCHEMA, and AZURE_SOURCE_DATA_SCHEMA) to separate raw data based on sources to ensure better maintainability



**Step 3: Loading Into Staging**

* Copied the raw data tables into a different staging schema loading_staging_schema_1 within Snowflake using dbt Core so as to preserve the irst loaded copy



**Step 4: Data Transformation**

* Performed data transformation (converting int to proper date format,changing the column names,establishing constraints like PK, and FK, etc) in DBT core models
* Loaded the clean datasets into separated into TRANSFORMED_DATA_SCHEMA
