{{ config(
    materialized='table'
) }}

select *
from {{ source('aws_source_data_schema', 'loan_tbl') }}
