
  
    

        create or replace transient table banking_data.transformed_data_schema.district
         as
        (

SELECT 
a1 AS district_code,
a2 AS district_name,
a3 AS region,
a4 AS no_of_inhabitants,
a5 AS no_of_municipalities_with_inhabitants_less_than_500,
a6 AS no_of_municipalities_with_inhabitants_between_500_and_1999,
a7 AS no_of_municipalities_with_inhabitants_between_2000_and_9999,
a8 AS no_of_municipalities_with_inhabitants_greater_than_9999,
a9 AS no_of_cities,
a10 AS ratio_of_urban_inhabitants,
a11 AS average_salary,
a14 AS no_of_entrepreneurs_per_100_inhabitants,
a15 AS no_of_committed_crime_2017,
a16 AS no_of_committed_crime_2018
FROM banking_data.staging_schema_1.district_tbl
        );
      
  