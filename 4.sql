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

