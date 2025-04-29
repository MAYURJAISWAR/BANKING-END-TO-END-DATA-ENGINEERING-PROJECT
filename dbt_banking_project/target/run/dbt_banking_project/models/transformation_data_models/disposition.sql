
  
    

        create or replace transient table banking_data.transformed_data_schema.disposition
         as
        (

SELECT disp_id,client_id,account_id,type
FROM banking_data.staging_schema_1.disposition_tbl
        );
      
  