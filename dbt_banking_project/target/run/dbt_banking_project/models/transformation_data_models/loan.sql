
  
    

        create or replace transient table banking_data.transformed_data_schema.loan
         as
        (
SELECT loan_id,account_id,
DATEADD(YEAR,23,TO_DATE(TO_VARCHAR(DATE),'YYMMDD')) AS `date`,
amount,duration,payment,
CASE 
WHEN UPPER(status)='A' THEN 'CONTRACT FINISHED'
WHEN UPPER(status)='B' THEN 'LOAN NOT PAID'
WHEN UPPER(status)='C' THEN 'RUNNING CONTRACT'
WHEN UPPER(status)='D' THEN 'CLIENT IN DEBT'
END AS status 
FROM banking_data.staging_schema_1.loan_tbl
        );
      
  