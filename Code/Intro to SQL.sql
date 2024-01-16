--Introduction to SQL,DB

--create table customer

CREATE TABLE customer
(
cust_id number,
cust_name varchar2(10),
mobile_no number(10),
dob  date,
city varchar2(10),
email_id varchar2(25)
);

--INSERT VALUES IN TABLE

INSERT INTO customer VALUES(100000,'Arun',9090909090,'8-Apr-00','Chennai','arun@gmail.com');

--Querying the table

SELECT * FROM customer;

--To learn the differenece between char and varchar, we are dropping and creating the table with one char and one varchar datatype

DROP TABLE customer;

CREATE TABLE customer
(
cust_id number,
cust_name varchar2(10),
mobile_no number(10),
dob  date,
city char(10),
email_id varchar2(25)
);

INSERT INTO customer VALUES(100000,'Arun',9090909090,'8-Apr-00','Chennai','arun@gmail.com');

/* INSERT IN ADDRESS MODE 

EASY for large set of values 
Entering '/' will ask for next set of values

SQL> INSERT INTO customer1 VALUES(&no1,&no2);
Enter value for no1: 44
Enter value for no2: 55
old   1: INSERT INTO customer1 VALUES(&no1,&no2)
new   1: INSERT INTO customer1 VALUES(44,55)

1 row created.

SQL> /
Enter value for no1: 66
Enter value for no2: 77
old   1: INSERT INTO customer1 VALUES(&no1,&no2)
new   1: INSERT INTO customer1 VALUES(66,77)

1 row created.

SQL> /
Enter value for no1: 77
Enter value for no2: 88
old   1: INSERT INTO customer1 VALUES(&no1,&no2)
new   1: INSERT INTO customer1 VALUES(77,88)

1 row created.

*/

SELECT * FROM customer;

SELECT LENGTH(city),LENGTH(email_id) FROM customer;

/* Length of city is static i.e 10 whereas length of email_id is dynamic i.e 14 while we gave 25 in varchar. 
LENGTH(CITY), LENGTH(EMAIL_ID)
10	             14
So it sums up that using varchar2 is best for memory optimization
*/

COMMIT;  -- commit is mandatory if you wanna  save your DML executions in DB