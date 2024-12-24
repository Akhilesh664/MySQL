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

