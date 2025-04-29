{{ config(
    materialized='table',
    post_hook=[
        "ALTER TABLE {{ this }} ADD CONSTRAINT pk_disp_id PRIMARY KEY(disp_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_disp_id_fk_account_id FOREIGN KEY(account_id) REFERENCES {{ ref('account') }}(account_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_disp_id_fk_client_id FOREIGN KEY(client_id) REFERENCES {{ ref('client') }}(client_id)",
    ]
) }}

SELECT disp_id,client_id,account_id,type
FROM {{ ref('disposition_tbl') }}