{{ config(
    materialized='table',
    post_hook=[
        "ALTER TABLE {{ this }} ADD CONSTRAINT pk_card_id PRIMARY KEY(card_id)",
        "ALTER TABLE {{ this }} 
        ADD CONSTRAINT pk_card_id_fk_disp_id FOREIGN KEY(disp_id) REFERENCES {{ ref('disposition') }}(disp_id)"
    ]
) }}

SELECT card_id,disp_id,
CASE 
WHEN LOWER(type)='junior' THEN 'Silver'
WHEN LOWER(type)='classic' THEN 'Gold'
ELSE 'Diamond'
END AS type,
DATEADD(YEAR, 23,TO_DATE(LEFT(issued_date, 6), 'YYMMDD')) AS issued_date
FROM {{ ref('card_tbl') }}