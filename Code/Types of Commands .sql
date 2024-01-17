-- Types of commands 

/*
DDL
DML
DQL
TCL
DCL
*/

--DML commands
--INSERT + COMMIT/ROLLBACK

SELECT * FROM customer;

INSERT INTO customer(cust_id,cust_name,mobile_no,dob,city,email_id) 
VALUES(100001,'Jack',8080808080,TO_DATE('12-15-2000','mm/dd/yyyy'),'Mumbai','jack15@gmail.com');

/* SQL Error: ORA-00984: column not allowed here
00984. 00000 -  "column not allowed here"

This error happens when you values are not given in proper format like quotes */

--ROLLBACK -Unroll all the DML transactions till last commit

ROLLBACK;
COMMIT;
/* BEFORE ROLLBACK - 2 records
AFTER ROLLBACK - 1 record */

-- Adding null in INSERT VALUES
--option 1 -- explicitly declare 'NULL'
INSERT INTO customer(cust_id,cust_name,mobile_no,dob,city,email_id)
VALUES(100002,'Mohan',NULL,TO_DATE('01/27/2000','mm/dd/yyyy'),'Kerala','mohan@gmail.com');

-- option 2 - by omitting the column in insert

INSERT INTO customer(cust_id,cust_name,dob,city,email_id)
VALUES(100002,'Mohan',TO_DATE('01/27/2000','mm/dd/yyyy'),'Kerala','mohan@gmail.com');

/*
SQL Error: ORA-00904: "CUSTOMER_NAME": invalid identifier
00904. 00000 -  "%s: invalid identifier"

If column name is wrong  above error is generated,example below */

INSERT INTO customer(cust_id,customer_name,dob,city,email_id)
VALUES(100002,'Mohan',TO_DATE('01/27/2000','mm/dd/yyyy'),'Kerala','mohan@gmail.com');


--UPDATE STATEMENT 
-- NO NEED OF TABLE KEYWORD IN UPDATE STATEMENT

UPDATE  customer 
SET mobile_no=9999999999;

--UPDATE WITHOUT WHERE CONDITION UPDATES MOBILE NO FOR ALL

UPDATE customer 
SET mobile_no=6766767676 
WHERE cust_name='Mohan';

--DDL/ALTER STATEMENT

ALTER TABLE customer 
ADD  country varchar2(25);

SELECT * FROM customer;

UPDATE customer
SET country='India';

COMMIT;

ALTER TABLE customer
DROP  COLUMN city;

DESC customer;

-- since cust_id is decalred as number, without precision we insert large no as cust_id 
INSERT INTO customer(cust_id,cust_name,dob,email_id)
VALUES(100002000000000000000000000,'Mohan',TO_DATE('01/27/2000','mm/dd/yyyy'),'mohan@gmail.com');


DELETE FROM customer 
WHERE cust_id=100002000000000000000000000;

COMMIT;

/* Suppose, if wanna insert a record that is higher precision that already declared precision,error is generated .
For Eg 
Hariharakumaran is 15 characters/bytes while we declared only 10 bytes 
*/
INSERT INTO customer(cust_id,cust_name,dob,email_id)
VALUES(100003,'Hariharakumaran',TO_DATE('08/14/2001','mm/dd/yyyy'),'kuumar@gmail.com');

--ORA-12899: value too large for column "TEST"."CUSTOMER"."CUST_NAME" (actual: 15, maximum: 10)

/* If you try change datatype of a column which has data already, then error will be generated
Eg:Adding pin-code to phone no
Phone no :+91-8080808080
*/


INSERT INTO customer(cust_id,cust_name,mobile_no,dob,email_id) 
VALUES(100001,'Jack','+91-8080808080',TO_DATE('12-15-2000','mm/dd/yyyy'),'jack15@gmail.com');

--ORA-01722: invalid number

--We cannot change datatype directly by commands  if data is already present

ALTER TABLE customer
MODIFY mobile_no  varchar2(15);

--01439. 00000 -  "column to be modified must be empty to change datatype"

/*
1.We can increase the precision eventhough  data is already present
2.We cannot decrease the precision,change datatype directly by commands  if data is already present
3.We cannot insert a value larger than the defined precision or value of another datatype 
*/

/* To change datatype of column with records, following steps are used
1.Backup the table
2.Truncate the table
3.Change the datatype.
4.Copy data from backup table
5.Drop backup table 
*/

--1.Backup the table 
CREATE TABLE customer_bkp AS SELECT * FROM customer;  -- same as CREATE TABLE customer_bkp AS SELECT * FROM customer WHERE 1=1;
SELECT * FROM customer_bkp;

--TIP:If you want only table structure,not data use WHERE 1=2; or WHERE [any false condition];
CREATE TABLE customer_bkp1 AS SELECT * FROM  customer WHERE 100=99;
DROP TABLE customer_bkp1;
SELECT * FROM customer_bkp1;

--2.TRUNCATE THE TABLE

TRUNCATE TABLE customer;
SELECT * FROM customer;

--3.MODIFY THE DATA TYPE

ALTER TABLE customer
MODIFY mobile_no  varchar2(15); --CHANGING THE DATATYPE 

ALTER TABLE customerYPE
MODIFY cust_id   number(9); --MODIFYONG THE DATATYPE

--4.Loading the data

INSERT INTO customer(SELECT * FROM customer_bkp);
SELECT * FROM customer;

---EXECUTING THE PREVIOUSLY DATATYPE CONSTRAINT QUERIES

INSERT INTO customer(cust_id,cust_name,mobile_no,dob,email_id) 
VALUES(100001,'Jack','+91-8080808080',TO_DATE('12-15-2000','mm/dd/yyyy'),'jack15@gmail.com'); 


--5.Drop backup table 

DROP TABLE customer_bkp;



COMMIT;

--SAVEPOINT COMMAND
--BOOKMARK 


CREATE TABLE customer1(no1 number(2),no2 number(2));

INSERT INTO customer1 VALUES(11,22);
SAVEPOINT a;
INSERT INTO customer1 VALUES(22,33);
SAVEPOINT b;
INSERT INTO customer1 VALUES(33,44);
SAVEPOINT c;
SELECT * FROM customer1; 

ROLLBACK TO a;
COMMIT ;

--RENAME command

ALTER TABLE customer 
RENAME COLUMN email_id TO mail_id;

ALTER TABLE customer 
RENAME COLUMN mobile_no TO mobile;

SELECT * FROM customer;

--END OF COMMANDS-----



