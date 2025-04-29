
  
    

        create or replace transient table banking_data.transformed_data_schema.order_table
         as
        (

SELECT order_id,account_id, bank_to,account_to,amount
FROM banking_data.staging_schema_1.order_tbl
        );
      
  