

WITH transformed_cte AS (
SELECT trans_id,account_id,
CASE
WHEN YEAR(date) = 2021 THEN DATE_FROM_PARTS(2017, MONTH(date), DAY(date))
WHEN YEAR(date) = 2020 THEN DATE_FROM_PARTS(2018, MONTH(date), DAY(date))
WHEN YEAR(date) = 2019 THEN date
WHEN YEAR(date) = 2018 THEN DATE_FROM_PARTS(2020, MONTH(date), DAY(date))
WHEN YEAR(date) = 2017 THEN DATE_FROM_PARTS(2021, MONTH(date), DAY(date))
WHEN YEAR(date) = 2016 THEN DATE_FROM_PARTS(2022, MONTH(date), DAY(date))
END AS txn_date,
type,operation,amount,balance,purpose,bank,account_partner_id
FROM banking_data.staging_schema_1.transaction_tbl
)
SELECT trans_id,account_id,txn_date,type,operation,amount,balance,purpose,
COALESCE(bank,
CASE WHEN YEAR(txn_date) = 2022 THEN 'Sky bank'
WHEN YEAR(txn_date) = 2021 THEN 'DBS Bank'
WHEN YEAR(txn_date) = 2018 THEN 'Southern Bank'
WHEN YEAR(txn_date) = 2017 THEN 'UNO Bank'
ELSE 'TBD'
END
) AS bank,
account_partner_id
FROM transformed_cte