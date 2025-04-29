
  
    

        create or replace transient table banking_data.transformed_data_schema.order
         as
        (

SELECT *
FROM banking_data.staging_schema_1.order_tbl
        );
      
  