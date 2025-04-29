{{ config(
    materialized='table',
    post_hook=[
        "ALTER TABLE {{ this }} ADD CONSTRAINT pk_order_id PRIMARY KEY(order_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_order_id_fk_account_id FOREIGN KEY(account_id) REFERENCES {{ ref('account') }}(account_id)"
    
    ]
) }}

SELECT order_id,account_id, bank_to,account_to,amount
FROM {{ ref('order_tbl') }}