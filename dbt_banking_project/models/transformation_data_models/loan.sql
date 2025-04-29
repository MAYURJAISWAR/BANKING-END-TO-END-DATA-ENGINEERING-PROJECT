{{ config(
    materialized='table',
    post_hook=[
        "ALTER TABLE {{ this }} ADD CONSTRAINT pk_loan_id PRIMARY KEY(loan_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_order_id_fk_account_id FOREIGN KEY(account_id) REFERENCES {{ ref('account') }}(account_id)"
    ]
) }}
SELECT loan_id,account_id,
DATEADD(YEAR,23,TO_DATE(TO_VARCHAR(DATE),'YYMMDD')) AS `date`,
amount,duration,payment,
CASE 
WHEN UPPER(status)='A' THEN 'CONTRACT FINISHED'
WHEN UPPER(status)='B' THEN 'LOAN NOT PAID'
WHEN UPPER(status)='C' THEN 'RUNNING CONTRACT'
WHEN UPPER(status)='D' THEN 'CLIENT IN DEBT'
END AS status 
FROM {{ ref('loan_tbl') }}