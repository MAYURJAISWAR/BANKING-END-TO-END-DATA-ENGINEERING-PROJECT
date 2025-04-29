
SELECT client_id,
TO_DATE(birth_date,'DD-MM-YYYY') AS birth_date,
district_id,
CASE WHEN MOD(gender,2)=0 THEN 'Female' ELSE 'Male' END AS gender
FROM banking_data.staging_schema_1.client_tbl