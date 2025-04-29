

SELECT card_id,disp_id,
CASE 
WHEN LOWER(type)='junior' THEN 'Silver'
WHEN LOWER(type)='classic' THEN 'Gold'
ELSE 'Diamond'
END AS type,
DATEADD(YEAR, 23,TO_DATE(LEFT(issued_date, 6), 'YYMMDD')) AS issued_date
FROM banking_data.staging_schema_1.card_tbl