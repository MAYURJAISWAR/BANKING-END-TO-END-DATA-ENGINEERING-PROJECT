
  
    

        create or replace transient table banking_data.staging_schema_1.district_tbl
         as
        (

select *
from banking_data.aws_source_data_schema.district_tbl
        );
      
  