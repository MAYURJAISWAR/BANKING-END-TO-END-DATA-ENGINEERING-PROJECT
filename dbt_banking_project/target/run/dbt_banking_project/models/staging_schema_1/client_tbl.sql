
  
    

        create or replace transient table banking_data.staging_schema_1.client_tbl
         as
        (

select *
from banking_data.azure_source_data_schema.client_tbl
        );
      
  