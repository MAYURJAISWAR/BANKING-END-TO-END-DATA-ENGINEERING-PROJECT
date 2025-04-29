{{ config(
    materialized='table'
) }}

select *
from {{ source('azure_source_data_schema', 'card_tbl') }}
