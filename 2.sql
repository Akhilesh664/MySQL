show databases;
-- create database regex1
create database regex1;
use regex1;
-- create table xyz
create table xyz(id int);
select * from xyz;
-- add values in table
insert into xyz values(-20);
insert into xyz values(2147483648); -- out of range 
select * from xyz;


-- ddl statement (Data defination language)
create table employee1(eid int unsigned); -- here we can increase the limit of value and in this we can not add negative value in it 
insert into employee1 values(2147483648);
select * from employee1;

-- Integer => tiny int(byte), medium int(3 byte), int(4 byte), bigint(8)
-- boolean => tinyint 
-- 2**8 => 255 (unsigned) => -128 to 127
create table employees2(id tinyint unsigned);
insert into employees2 values(255);
select * from employees2;

insert into employees2 value(True);
select * from employees2;

create table abc(salary double(5, 2)); -- (5,2) mean total number of digit including (.) will be 5 and 2 will be value after decimal place
select * from abc;
insert into abc values(5.602);
insert into abc values(120.1);
insert into abc values(5234.6); -- using digit 6 give error

-- 0 to 256 unsigned, -127 to 128
create table test_bool (i BOOL);
insert into test_bool values (true),(false);
select * from test_bool;

create table ep2(name1 char(4));
insert ep2 values("zzzz");
insert ep2 values("zzzz     a"); -- error because its size is out of name1 assigned  char(4)
select name1, length(name1) from ep2; -- length in char ignore / remove ws at last

create table ep_var(name1 varchar(3)); -- in varchar it consider space also 
insert ep_var values("X_-_"); -- error because its size is out of name1 assigned  char(4)
insert ep_var values("p    "); -- truncate all extras space out of varchar(3)
select name1, length(name1) from ep_var; -- length in char ignore / remove ws at last
select * from ep_var;

-- yyyy-MM-dd  hh:mm:ss
create table e1(dob date);
insert into e1 values('2024-12-5');
select * from e1;


create database regex;
use regex;
create table product(pid int, pname varchar(20),  price int);
insert into product values 
	(10,"tv",100),
	(20,"mobile",200),
	(30,"gyser",4000),
	(40,"remote",1000);
select * from product;

create table orders(oid int, city varchar(50), product_id int);
insert into orders values 
	(1991,"jaipur",10),
	(1992,"goa",20),
	(1993,"shimla",40),
	(1994,"agra",10),
	(1995,"delhi",80);
select * from orders;

--  old version of writing join
-- cross join/cartisiean join = 1st table rows (m), 2nd table rows (n): formula of cross join m*n 
-- all the possible combination of each row of 1st table matching with every row of 2nd table 
select o.oid, o.city, o.product_id, p.pid, p.pname, p.price 
from 
	orders as o
join 
	product as p
where 
	o.product_id = p.pid;

-- == new version of writing join
select o.oid, o.city, o.product_id, p.pid, p.pname, p.price 
from 
	orders as o
inner join 
	product as p
on 
	o.product_id = p.pid;

-- left join =================
select o.oid, o.city, o.product_id, p.pid, p.pname, p.price 
from 
	orders as o
left join 
	product as p
on 
	o.product_id = p.pid; 

-- right join =================
select o.oid, o.city, o.product_id, p.pid, p.pname, p.price 
from 
	orders as o
right join 
	product as p
on 
	o.product_id = p.pid; 
    
use sakila;
select * from actor;
select * from film_actor;

-- Q. Get actor id, fullname of actor, film_id , last_update col. from these two tables alter
select a.actor_id, concat(a.first_name," ",a.last_name), f.film_id, f.last_update 
from 
	actor as a
inner join
	film_actor as f
on 
a.actor_id = f.actor_id;



-- Self Joint
use regex;
create table employee(eid int, ename varchar(20), manager_id int);
insert into employee values
(10, "akhilesh", null), 
(20, "akshay", 30),
(30, "aniket", 10),
(40, "prem", 30);
select * from employee;

select emp.eid, emp.ename, emp.manager_id, mgr.eid, mgr.ename 
from employee as emp
join employee as mgr
where emp.manager_id = mgr.eid;


-- Natural Join 
-- Note* In natural join there is no condition, if there is now common column in two table then it acts as cross join example below no overlaping
-- Note* If there is common in both table then it acts as inner join mean commom column orlaps each other 
select * from orders;
select * from product;
select * from orders natural join product;
