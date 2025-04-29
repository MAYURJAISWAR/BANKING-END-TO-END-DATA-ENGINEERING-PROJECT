{{ config(
    materialized='table'
) }}

select *
from {{ source('aws_source_data_schema', 'district_tbl') }}


