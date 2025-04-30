-- AWS SOURCES TABLE STRUCTURE


CREATE TABLE district_tbl(
a1 INT PRIMARY KEY,
a2 VARCHAR(100),
a3 VARCHAR(100),
a4 INT,
a5 INT,
a6 INT,
a7 INT,
a8 INT,	
a9 INT,
a10	FLOAT,
a11 INT,
a12 FLOAT,
a13 FLOAT,
a14 INT,
a15	INT,
a16 INT
);


CREATE TABLE account_tbl(
account_id INT PRIMARY KEY,
district_id	INT,
frequency	VARCHAR(40),
date INT,
account_type VARCHAR(100) 
); 


CREATE TABLE order_tbl (
order_id	INT PRIMARY KEY,
account_id	INT,
bank_to	VARCHAR(45),
account_to	INT,
amount FLOAT
);

CREATE TABLE loan_tbl(
loan_id	INT ,
account_id	INT,
date INT,
amount	INT,
duration	INT,
payment	INT,
status VARCHAR(35)
);


CREATE TABLE transaction_tbl(
trans_id INT,	
account_id	INT,
date	DATE,
type	VARCHAR(30),
operation	VARCHAR(40),
amount	INT,
balance	FLOAT,
purpose	VARCHAR(40),
bank	VARCHAR(45),
account_partner_id INT
);


-- AZURE SOURCE TABLE STRUCTURE


CREATE TABLE client_tbl(
client_id INT PRIMARY KEY,
birth_date VARCHAR(15),
district_id INT
);

CREATE TABLE disposition_tbl(
disp_id INT PRIMARY KEY,
client_id INT,
account_id INT,
type VARCHAR(15)
);

CREATE TABLE card_tbl(
card_id	INT PRIMARY KEY,
disp_id	INT,
type VARCHAR(10),
issued_date INT
);