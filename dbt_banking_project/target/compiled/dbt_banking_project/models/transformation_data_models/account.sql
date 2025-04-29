

WITH field_transform_cte AS (
    SELECT account_id, district_id,
    CASE WHEN UPPER(frequency) = 'POPLATEK TYDNE' THEN 'WEEKLY ISSUANCE'
         WHEN UPPER(frequency) = 'POPLATEK MESICNE' THEN 'MONTHLY ISSUANCE'
         WHEN UPPER(frequency) = 'POPLATEK PO OBRATU' THEN 'ISSUANCE AFTER TRANSACTION'
         ELSE 'UNKNOWN'
        END AS frequency,
        DATEADD(YEAR, 24, TO_DATE(TO_VARCHAR(date), 'YYMMDD')) AS "date",
        account_type
        FROM banking_data.staging_schema_1.account_tbl
)

SELECT account_id,district_id,frequency,"date",account_type,
CASE WHEN frequency = 'WEEKLY ISSUANCE' THEN 'DIAMOND'
     WHEN frequency = 'MONTHLY ISSUANCE' THEN 'SILVER'
     WHEN frequency = 'ISSUANCE AFTER TRANSACTION' THEN 'GOLD'
     ELSE 'UNKNOWN'
     END AS card_assigned
FROM field_transform_cte