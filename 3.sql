use regex;

create table test (id int, name varchar(20));
insert into test value(1,"anil");
insert into test value(2,"prem");
select * from test;

create table test (eid int);
insert into test values (200); 
insert into test values (null); 
select * from test;

-- not null
create table test (eid int not null);
insert into test values (200); 
insert into test values (null); -- error
select * from test;

-- To delete table from databases 
drop table test;

-- unique constraints
create table test1 (eid int unique);
insert into test1 values (200); 
insert into test1 values (null);
select * from test1;

-- default constraints -- fill default data value in table if not assigned values
create table test2 (eid int default 0,name varchar(20));
insert into test2(eid, name) values (100,"abhishek"); 
insert into test2(eid, name) values (null, "aman");
insert into test2(name) values ("prem");
select * from test2;
select * from test2 where eid is null;


-- primary key
create table test3 (eid int primary key auto_increment, name varchar(20));
insert into test3(eid, name) values (100,"abhishek"); 
insert into test3(eid, name) values (200, "aman");
insert into test3(eid, name) values (300, "krish");
insert into test3(name) values ("prem");
select * from test3;

-- foriegnn key
create database regexconst;
use regexconst;
create table product(pid int primary key, pname varchar(20),  price int);
insert into product values 
	(10,"tv",100),
	(20,"mobile",200),
	(30,"gyser",4000),
	(40,"remote",1000);
select * from product;

-- foreign key: direct to either [primary key in diff table /or/ Unique]
create table orders(oid int, city varchar(50), product_id int,
foreign key (product_id) references product(pid)); -- foreign key (column in this table name) references other table name(column similar) 
insert into orders values 
	(1991,"jaipur",10),
	(1992,"goa",20),
	(1993,"shimla",40),
	(1994,"agra",10);
select * from orders;


-- DDL => data defination language
-- create , drop, truncate, alter

create table test(id int, name1 varchar(20));
insert into test values(10, "anushka");
insert into test values("virushka"); -- error
insert into test(name1) values("anushka");
insert into test values(20,"ramesh");
select * from test;  -- insert => DML operation

-- update 
update test set name1 = "pqr" where id = 10;
select * from test;  -- update => DML operation [update all data values in table where id=10, if not given where it change complete table
-- delete
delete from test where id is null;
select * from test;  -- delete => DML operation
-- drop
drop table test; -- drop whole table drom database
-- truncate
truncate test; -- truncate remove all row from table, without removing structure from table 
select * from test;  -- delete => DML operation

-- alter table
create table companies(id int);
insert into companies values(10);
select * from companies;

-- alter command (add)
alter table companies add column employee_count3 int not null;
select * from companies;

-- alter command (drop)
alter table companies drop column employee_count3;
select * from companies;

-- ddl
-- Rename table
rename table companies to newcompany1;
select * from companies; -- error table name has changed
select * from newcompany1;

-- alter command (rename) 
alter table newcompany1 rename to companies;
select * from newcompany1; -- error table name has changed
select * from companies;

-- alter command (table to primary key)
alter table companies add primary key (id);
insert into companies values (20);
select * from companies;

-- alter drop primary key
alter table companies add constraint regexcompany_uk unique(company_name);

-- alter command (modify)
alter table companies modify id double;

-- alter command (change)
alter table companies change id newids varchar(6);


create user bob identified by 'bob';
select current_user();


select * from mysql.user;
select * from mysql.user where user = 'bob';
create user 'samay' identified by 'password';
create user 'samay'@192.168.10.1 identified by 'password';

drop user 'samay';
drop user samay@'192.168.10.1';

use sakila;
show tables;
grant all privileges on sakila.* to bob;

show grants for 'bob';
revoke all privileges on sakila.* from bob;
grant select(id) on sakila.test to bob;


-- locking user
alter user 'bob' account lock;

-- unlocking user
alter user 'bob' account unlock;


-- creating role
create role sales1;
grant select on sakila.* to sales1;

-- grant role to user, example: sales department have acces of saome table which neet to give acces to bob
grant sales1 to bob;
flush privileges; -- to reload all properties
show grants for bob;
set default role all to bob;  -- to set group role



