{{ config(
    materialized='table',
    post_hook=[
        "ALTER TABLE {{ this }} ADD CONSTRAINT pk_client_id PRIMARY KEY(client_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_client_id_fk_district_id FOREIGN KEY(district_id) REFERENCES {{ ref('district') }}(district_code)"
    ]
) }}
SELECT client_id,
TO_DATE(birth_date,'DD-MM-YYYY') AS birth_date,
district_id,
CASE WHEN MOD(gender,2)=0 THEN 'Female' ELSE 'Male' END AS gender
FROM {{ ref('client_tbl') }}
