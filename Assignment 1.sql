create database ineuron_assignmts;
use  ineuron_assignmts;
-- TASK-1
-- create table ProductSale with below attributes, respective data types
create table ProductSale(
product varchar(50),
quantity int,
unit_price float);

-- insert given values into ProductSale table
insert into ProductSale values ('milk', 3, 10);
insert into ProductSale values ('bread', 7, 3);
insert into ProductSale values ('bread', 5, 2);
select * from ProductSale;

-- select columns product, SUM(quantity *  unit_price) as 'total_price'
select product, SUM(quantity *  unit_price) as 'total_price'from ProductSale 
group by product                -- group by to aggregate per product
order by product desc;       -- order by to sort the results by product in descending

-- TASK-2

create table phones (
name varchar(20) not null unique,
phone_number integer not null unique);

insert into phones (name,phone_number) values ("Jack",1234);
insert into phones (name,phone_number) values ("Lena",3333);
insert into phones (name,phone_number) values ("Mark",9999);
insert into phones (name,phone_number) values ("Anne",7582);

select * from phones;

create table calls (
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique(id));

insert into calls (id,caller,callee,duration) values (25,1234,7582,8);
insert into calls (id,caller,callee,duration) values (7,9999,7582,1);
insert into calls (id,caller,callee,duration) values (18,9999,3333,4);
insert into calls (id,caller,callee,duration) values (2,7582,3333,3);
insert into calls (id,caller,callee,duration) values (3,3333,1234,1);
insert into calls (id,caller,callee,duration) values (21,3333,1234,1);


WITH cte AS (
SELECT a.caller FROM (
SELECT id,caller,duration FROM calls )
AS a 
INNER join(
SELECT id,callee,duration FROM calls)
 AS b ON a.id = b.id
WHERE (a.duration + b.duration) >= 10
UNION ALL
SELECT b.callee
FROM (
SELECT id, caller, duration
FROM calls
) AS a
inner join(
select id,callee, duration FROM calls) 
AS b ON a.id = b.id
WHERE (a.duration + b.duration) >= 10) 
SELECT name FROM cte c
INNER JOIN phones p ON c.CALLER = p.phone_number;

-- task-3

CREATE TABLE transactions( 
Amount INTEGER NOT NULL,
Date  DATE NOT NULL);

INSERT INTO transactions(Amount, Date) VALUES (1000, '2020-01-06');
INSERT INTO transactions(Amount, Date) VALUES (-10,'2020-01-14');
INSERT INTO transactions(Amount, Date) VALUES (-75,'2020-01-20');
INSERT INTO transactions(Amount, Date) VALUES (-5,'2020-01-25');
INSERT INTO transactions(Amount, Date) VALUES (-4,'2020-01-29');
INSERT INTO transactions(Amount, Date) VALUES (2000, '2020-03-10');
INSERT INTO transactions(Amount, Date) VALUES (-75, '2020-03-12');
INSERT INTO transactions(Amount, Date) VALUES (-20,'2020-03-15');
INSERT INTO transactions(Amount, Date) VALUES (40, '2020-03-15');
INSERT INTO transactions(Amount, Date) VALUES (-50, '2020-03-17');
INSERT INTO transactions(Amount, Date) VALUES (200, '2020-10-10');
INSERT INTO transactions(Amount, Date) VALUES  (-200,'2020-10-10');
 SELECT * FROM transactions;
 
 WITH free
AS ( 
WITH cte2 AS (
SELECT *
,sum(amount) OVER (PARTITION BY month( date )) AS total_tranasactions
,count(amount) OVER (PARTITION BY month( date )) AS number_of_transactions
FROM transactions
WHERE amount LIKE '-%')
SELECT *
FROM cte2
WHERE total_tranasactions < - 100
AND number_of_transactions >= 3
GROUP BY 3
) (
SELECT sum(amount) - (
12 - (
SELECT DISTINCT (count(*)) AS a
FROM free
)
)* (5) AS balance
FROM transactions);

