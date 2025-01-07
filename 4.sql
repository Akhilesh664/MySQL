use employees;
select * from sakila.payment;

select max(amount) from sakila.payment;
select max(amount) from sakila.payment where amount < 11.99;

-- window function

use sakila;
create table employees(id int primary key auto_increment, dept varchar(20), salary int);
insert into employees(dept, salary) values ("hr",200),("hr",300),("hr",100)
,("marketing",70),("marketing",50),
("marketing",200),("marketing",400),
("marketing",200),("marketing",600),("dsa",150),("dsa",120),("dsa",40),("dsa",90),("dsa",500);
select * from employees;

-- Aggrestion / Analatical function => calculation 
-- har ek row ke sath calculation hogi or vo dikhege
select sum(salary) from employees;
select sum(salary) from employees where dept='hr';
select *, (select sum(salary) from employees) from employees;

-- OR [instead of using subquery use window function]
-- over is used in window function
select *, sum(salary) over() from employees;
select *, sum(salary) over(partition by dept) from employees; -- make partition btw diff dept sumsalary
select *, sum(salary) over(order by salary) from employees; -- arrange orderly with increasng sum of salary 
select *, sum(salary) over(partition by dept order by salary) from employees; -- arrange orderly with increasng sum of salary , and partition by dept whenever new dept comes starts with that salary

-- Rank function -- give rank to row on the basis of overbut in case of same row data it give same rank to all but last it give incremented rank of number of similar data come accross (condition/orderb y )
select *, 
rank() over( order by salary desc) 
from employees; 

-- Dense_Rank function -- give dense_rank to row on the basis of over but in same data condition it show same rank later on increment of 1(condition/order by)
select *, 
rank() over( order by salary desc),
dense_rank() over( order by salary desc),
row_number() over( order by salary desc) -- simply give rank to rows no matter data is same or not 
from employees; 

-- Lead -- to show second row data side by side with first row
select * ,
lead(salary,1) over() 
from employees;

select * ,
lead(salary,2) over(partition by dept) -- jump by 2
from employees;

select * ,
lead(salary,2, 300) over(partition by dept) -- fill null with 300 
from employees;

-- skipping by 1 from top
select *, 
rank() over( order by salary desc) as sal 
from employees
limit 2, 1; -- skiping by 1 


select * 
from (
	select *, 
	rank() over( order by salary desc) as sal
	from employees 
    ) as xyz 
    where sal = 2;

-- Co-related Subquery
-- A correlated subquery is a subquery that contains a reference to a table that 
-- 		also appears in the outer query. For example: SELECT * FROM t1 
-- 		WHERE column1 = ANY (SELECT column1 FROM t2 WHERE t2.
use employees;
select  * from employees;
select * from dept_emp;
select * from titles;

select emp_no, first_name
from employees;

-- by join (1 way)
select from_date from dept_emp as d join employees 
where d.emp_no = employees.emp_no;

-- Co-Related Subquery (2 way)
select emp_no, first_name, hire_date
from employees where hire_date in
	(select from_date from dept_emp 
    where emp_no=employees.emp_no);


-- Ques). Getting the employees first name, birth date, whose who are currently doing work as manager position 
select * from employees;
select * from titles;

-- by join (1 way)
select e.emp_no ,e.first_name, e.birth_date
from employees as e join titles as t
where (e.emp_no = t.emp_no) and title = "Manager";

-- from corelated subquery (2 way)
select emp_no, first_name, birth_date
from employees where emp_no in
	(select emp_no from titles
    where emp_no = employees.emp_no and title="Manager");


-- Ques). Getting emp_no, first_name for those employees where the hire_date employee is greater then the oldest date from from_date column 
select * from employees;
select * from titles;
    
SELECT emp_no, first_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT MIN(from_date)
    FROM titles
);

-- Ques). Getting empno, firstname, last name, hire_date only for who is doinging work as 'assistant manager' and hiring date less then manager's hiring date
select * from employees;
select * from titles;

select emp_no, first_name, last_name, hire_date
from employees join titles using (emp_no)
where title = 'Assistant Engineer'
and hire_date < any 
	(select hire_date from employees join titles
	using (emp_no) where title = 'Manager');


-- Views [virtual table, secure, reusablity, simlifies]
# view => data => quert store
use sakila;

create view actor_view as 
select actor.actor_id, first_name,  film_id
from actor join film_actor
where actor.actor_id = film_actor.actor_id;

select * from actor_view;

-- getting actor, fil id, film actor find film id and the film it worked 
select * from actor;
select * from film;
select * from film_actor;

-- [create or replace view] search is same kind of name of view is presented or not if no make new view
create or replace view aview as
select a.actor_id, f.film_id, fm.title 
from actor as a join film_actor as f
join film fm
where a.actor_id = f.actor_id and f.film_id = fm.film_id; 

select * from aview;

-- make md table student ,studentname insert 3 rows
-- make select * view
-- now try to update view is it possible 

use employees;
create table md (id int(5), name varchar(20));
select * from md;
insert into md values(1,"anil"),
						(2,"amit"),
						(3,"prem");

create view md_view as
select * from md;

select * from md_view;
UPDATE md_view
SET name = "ankit"
WHERE id = 1;

select * from md_view;

-- Ques). crete one view table on employees using group_by
use employees;
select * from employees;

alter VIEW newtable AS
SELECT 
    gender, 
    MIN(first_name) AS first_name
FROM 
    employees
GROUP BY 
    gender; 

select * from newtable;


-- [With Check Option] : complex view we cannot run ddl, dcl task where condition not fullfill
create view v1 as 
select * from employees
where emp_no > 10005
with check option; 

select * from v1;
update v1 set first_name = "abc" where emp_no = 10001;
select * from v1;


--
-- Create schema demo_db
--

CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;

DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `brand` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

select * from brands;

--
-- Dumping data for table `brands`
--

-- !40000 ALTER TABLE `brands` DISABLE KEYS 
INSERT INTO `brands` (`id`,`product_id`,`brand`) VALUES 
 (1,383741444,'Fujifilm'),
 (2,383741454,'Fujifilm'),
 (3,383741464,'Fujifilm'),
 (4,383741474,'Fujifilm'),
 (5,383741484,'Olympus'),
 (6,383741494,'Olympus'),
 (7,383750454,'Fujifilm'),
 (8,383751734,'Panasonic'),
 (9,383751744,'Panasonic'),
 (10,383751754,'Panasonic'),
 (11,383751824,'Panasonic'),
 (12,383751834,'Panasonic'),
 (13,383751844,'Panasonic');
-- !40000 ALTER TABLE `brands` ENABLE KEYS

select * from brands;
 
--
-- Definition of table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `region_id` varchar(100) NOT NULL,
  `value` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select * from invoices;


--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`region_id`,`value`) VALUES 
 ('region1',573.44),
 ('region1',145.54),
 ('region1',417.84),
 ('region1',203.89),
 ('region1',301.14),
 ('region1',340.04),
 ('region1',495.64),
 ('region1',515.09),
 ('region1',398.39),
 ('region2',262.24),
 ('region2',437.29),
 ('region2',320.59),
 ('region2',242.79),
 ('region2',184.44),
 ('region2',164.99),
 ('region2',612.34),
 ('region2',476.19),
 ('region2',281.69),
 ('region3',359.49),
 ('region3',378.94),
 ('region3',592.89),
 ('region3',534.54),
 ('region3',223.34),
 ('region3',456.74),
 ('region3',553.99);

select * from invoices;


--
-- Definition of table `order_lines`
--

DROP TABLE IF EXISTS `order_lines`;
CREATE TABLE `order_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

select * from order_lines;

--
-- Dumping data for table `order_lines`
--

INSERT INTO `order_lines` (`id`,`order_id`,`product_id`,`quantity`) VALUES 
 (1,1,383741444,1),
 (2,1,383741484,1),
 (3,2,383751754,1),
 (4,2,383741494,2),
 (5,2,383741464,1),
 (6,3,383751754,1),
 (7,4,383741444,2),
 (8,4,383741464,3),
 (9,5,383751844,1),
 (10,5,383741494,1),
 (11,6,383751754,1),
 (12,6,383741444,2),
 (13,6,383751744,1),
 (14,7,383741494,1),
 (15,7,383751844,1),
 (16,7,383741464,1),
 (17,7,383751754,1);

select * from order_lines;
 
 
--
-- Definition of table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `order_value` float(10,2) NOT NULL,
  `order_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

select * from orders;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`,`order_date`,`order_value`,`order_status`) VALUES 
 (1,'2012-02-09 20:26:31',240.00,'ORDERED'),
 (2,'2012-02-09 20:28:00',475.00,'ORDERED'),
 (3,'2012-02-09 20:34:05',115.00,'ORDERED'),
 (4,'2012-02-09 20:39:35',600.00,'ORDERED'),
 (5,'2012-02-09 20:52:30',280.00,'ORDERED'),
 (6,'2012-02-09 20:53:18',470.00,'ORDERED'),
 (7,'2012-02-09 20:55:47',515.00,'ORDERED');
 
select * from orders;
 
--
-- Definition of table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` int(20) NOT NULL DEFAULT '0',
  `product_name` varchar(200) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select * from products;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`,`product_name`,`price`) VALUES 
 (383741444,'Fuji 16MP Digital Camera - Black',120.00),
 (383741454,'Fuji 16MP Digital Camera - Silver',120.00),
 (383741464,'Fuji 16MP Digital Camera - Pink',120.00),
 (383741474,'Fuji 16MP Digital Camera - Red',120.00),
 (383741484,'Olympus 14MP Digital Camera Black',120.00),
 (383741494,'Olympus 14MP Digital Camera Silver',120.00),
 (383750454,'Fuji 14MP 30x Optical Zoom Camera',120.00),
 (383751734,'Panasonic 14MP Digital Camera Blue',115.00),
 (383751744,'Panasonic 14MP Digital Camera Red',115.00),
 (383751754,'Panasonic 14MP Digital Camera Pink',115.00),
 (383751824,'Panasonic 16MP Digital Camera Black',160.00),
 (383751834,'Panasonic 16MP Digital Camera Silver',160.00),
 (383751844,'Panasonic 16MP Digital Camera Red',160.00);
 
 select * from products;
 
 
-- find out the top 3 product_id based on quntity sold?
select * from order_lines;

SELECT listOfOrder.product_id, sum(listOfOrder.quantity) AS Total_quantity
FROM order_lines listOfOrder
GROUP BY listOfOrder.product_id
ORDER BY Total_quantity DESC
LIMIT 3;

-- get order_date, product_id, product_name, order_id which has bessn sold in the multilple of 2?
select * from products;
select * from orders;
select * from order_lines;

select o.order_date, ol.product_id, p.product_name, ol.order_id
from order_lines ol
join orders o on ol.order_id = o.id
join products p on ol.product_id = p.product_id
where ol.quantity % 2 = 0;

-- get the brand name, order value, product_name for each product sold?

SELECT b.brand, o.order_value, p.product_name
FROM order_lines ol
JOIN orders o ON ol.order_id = o.id
JOIN products p ON ol.product_id = p.product_id
JOIN brands b ON p.product_id = b.product_id;

-- get the avg orderValue for each order which has bear placed after half mn hour?

SELECT AVG(o.order_value) AS avg_order_value
FROM orders o
WHERE TIMESTAMPDIFF(MINUTE, '2012-02-09 20:00:00', o.order_date) > 30;

-- get the order_id the no. of quantities for each brand?
 
 SELECT ol.order_id, b.brand, SUM(ol.quantity) AS total_quantity
FROM order_lines ol
JOIN products p ON ol.product_id = p.product_id
JOIN brands b ON p.product_id = b.product_id
GROUP BY ol.order_id, b.brand;