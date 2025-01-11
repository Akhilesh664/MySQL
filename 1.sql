Show Databases;
use sakila;
Show Tables;

select  * from actor;
select actor_id, first_name from actor;
select actor_id, first_name,10, actor_id+10 from actor;
select * from actor where actor_id = 10;

-- like operator => pattern
select * from actor where first_name ='ED';
-- % 0 or more character
select * from actor where first_name like 'E%';
select * from actor where first_name like '%E';
select * from actor where first_name like '%E%';
select * from actor where first_name like '%E%' or first_name like 'T%';
select * from actor where first_name like '_D%';
select * from actor where first_name like '%D_';
SELECT name FROM world WHERE name LIKE '_%x%_';
-- SELECT name FROM world WHERE name LIKE 'C%_%ia';
  
-- String Functions
-- concat
select * from actor;
select concat(first_name, last_name) from actor;
select concat("Mr ", first_name, ' ', last_name) from actor;
select concat_ws(" ","Mr", first_name, last_name) from actor;
select first_name, substr(first_name, 2) from actor;
select first_name, substr(first_name, 2, 3) from actor; -- L to R
select first_name, substr(first_name, -4,2 ) from actor; -- R to L
select first_name, instr(first_name, 'L') from actor; -- index of target
select first_name, locate('E',first_name, 2) from actor; -- index of target after n

select first_name, length(first_name) from actor; -- length of data but we prefer char_length
select first_name, char_length(first_name) from actor; 

-- dummy table (dual) -- for tasting logic in dummy table
select 10+2 from dual;
select "  hello  " from dual;
select trim(  "hello"  ) from dual; -- to remove extra ws
select trim(  "hel    lo"  ) from dual;
select trim(trailing 'l' from "   hello  xllll") from dual;

-- lpad, rpad (left/right pad)
select first_name, lpad(first_name, 6, "#") from actor;
select first_name, rpad(first_name, 6, "#") from actor;

-- numbric functions
#round, truncate, floor, mod, pow, ceil

select round(12.3) from dual; -- roundoff
select round(12.845, 2) from dual; -- roundoff with decimal number
select round(24.845, -1) from dual; -- roundoff with decimal number before decimal
select truncate(24.845, 2) from dual; -- remove after 2 from decimal with decimal number
select floor(10.999999) from dual; -- floor value 
select ceil(10.999999) from dual; -- ceil value 
select floor(10.999999), ceil(10.001) from dual; -- both value 
select mod(123, 5) from dual; -- remainder
select pow(4, 2) from dual; -- power 

-- date functions
select current_date(), curtime(), current_timestamp() from dual;
select now(), adddate(now(),2) from dual; -- add date 2 
select now(), adddate(now(), interval 2 month) from dual; -- add 2 month
select datediff(now(), '2024-12-28') from dual; -- date difference
select last_day(now()) from dual; -- last date in cruent month
select month(now()) from dual; -- month 

select date_format(now(), "current day is %a") from dual;
select date_format(now(), "current month is %b") from dual;
select date_format(now(), "current month in number is %c") from dual;
select date_format(now(), "current date is %d") from dual;
select date_format(now(), "current day is %a %M %Y") from dual;


-- multi-row functions
use sakila;
select * from payment;
select distinct(customer_id) from payment;
select distinct(customer_id), amount from payment;
select sum(amount) from payment;
select sum(amount), count(amount), count(*), avg(amount) from payment;
select sum(amount) from payment where customer_id=2; -- sum of amount which  having id 2
select distinct(customer_id), amount from payment;
select customer_id from payment group by customer_id; -- the name with which group by happen select should be same
select customer_id, sum(amount), count(*) from payment group by customer_id;
select sum(customer_id) from payment group by staff_id;
select month(payment_date), sum(amount), count(*)
	from payment
    group by month(payment_date) 
    having count(*) > 2000;
select * from payment;
select customer_id, sum(amount) as Total from payment group by customer_id order by Total desc;

select * from address;
select count(address), count(address2) from address;
-- get distrinct name, total district present , and sum of city id fror each district
select district, count(district), sum(city_id) from address group by district;
select city_id, count(*) from address where city_id >5 group by city_id;
select city_id, count(district) from address group by city_id having count(district)>= 2; -- filter data --it search in grouped data and checking condition having

select * from address order by district ;
select * from address order by district, city_id desc;

-- subquery
select * from payment;
select amount from payment where payment_id =3;
select payment_id from payment where amount = (select amount from payment where payment_id =3);

-- get payment , staffid, rental id, amount only for that -- where rental id is greater then the rental id of payment id 4
select payment_id, staff_id, amount from payment where rental_id >(select rental_id from payment where payment_id = 4); 
 
 -- Question: Get paymentid , amount  , 10 % increment in amount for those payment 
 -- where the month of payment_date is equal to month of id  payment_id = 5
select payment_id, amount, amount*1.1 as increasedAmount from payment 
	where month(payment_date) = (select month(payment_date) from 
	payment where payment_id = 5);

-- Question: Get only the customer id and total number of payment done by each customer only for those whose  
-- total no. of payment should be greater then the total number payment done by customer id 2
select * from payment;
select customer_id, count(payment_id) as TotalPayment
	from payment  group by customer_id having count(payment_id) > (select count(payment_id) from payment 
    where customer_id =2); 

-- =========================================
use sakila;
select * from payment;
select * from payment where payment_id = 1 or payment_id = 3;
select amount from payment where payment_id in (1, 3); -- chech element(1,3,...) is in the data or not

select * from payment
	where amount in (select amount from payment where payment_id = 1 or payment_id = 3);

-- any amount equal to 2.99 or 5.99
select * from payment
	where amount = any (select amount from payment where payment_id = 1 or payment_id = 3);
-- (> any) : greter then the minimum value of subquery
-- (< any) : smaller then the maximum value of subquery
-- (= any) : equal to any subquery
select * from payment
	where amount > any (select amount from payment where payment_id = 1 or payment_id = 3);
select * from payment
	where amount < all (select amount from payment where payment_id = 1 or payment_id = 3);
select count(*) from payment
	where amount > any (select amount from payment where payment_id = 1 or payment_id = 3);




-- ==============
-- Ternary operator [condition ? true : false]
use sakila;
select * from actor;

select first_name,
	if(first_name='nick',0,1)
	from actor;

select first_name,
	if(first_name='nick',0, if(first_name="ed", 2, "not value"))
	from actor;

-- better then if else
select first_name,
case
	when first_name='nick' then 0
	when first_name='ed' then 1
    else "no value"
end as "NewCol"
	from actor;

-- Ques: get payment_id, customer_id, amount, month of payment date & quarter of payment_date 
-- with following increment in the amount 
-- if amount is more then 2 $ then increase 10%, 
-- if amount is more then 5$ then increase 25%, 
-- if amount is more then 8$ then increase 50%, 
-- otherwise 5%. 
select * from payment;
SELECT 
    payment_id, 
    customer_id,  
    CASE
        WHEN amount > 8.00 THEN amount * 1.50 -- Apply 50% increase
        WHEN amount > 5.00 THEN amount * 1.25 -- Apply 25% increase
        WHEN amount > 2.00 THEN amount * 1.10 -- Apply 10% increase
        ELSE amount * 1.05 -- Apply 5% increase
    END AS adjusted_amount,
    MONTH(payment_date) AS payment_month,
    QUARTER(payment_date) AS payment_quarter
FROM payment;
	
    

--   ==================================
use sakila;
select * from payment;
use employees;
select * from salaries;

--   Q2. Write a query to fetch the employees who joined in the last 30 days.from-date is the column of hiring of candidate
SELECT 
    emp_no,
    salary, 
    from_date, 
    to_date
FROM 
    salaries
WHERE
    from_date >= to_date - INTERVAL 30 DAY;

-- Q3. Find the average age of employees in each gender and 
--     show only gender with more than 5 employees.

select * from employees;
select emp_no, (hire_date - birth_date) 
from 
	employees
limit 5;


-- AVG(hire_date - birth_date) AS average_age,

SELECT 
	gender, 
    TIMESTAMPDIFF(YEAR, birth_date, hire_date) AS age_at_hire
FROM 
    employees
GROUP BY 
    gender
HAVING 
    COUNT(emp_no) > 5;
    
--  Find the average age of employees in each gender and show only gener with more than 5 employees.
SELECT 
    gender, 
    AVG(TIMESTAMPDIFF(YEAR, birth_date, hire_date)) AS average_age_at_hire,
    COUNT(emp_no) AS employee_count
FROM 
    employees
GROUP BY 
    gender
HAVING 
    COUNT(emp_no) > 5;

--   Q4. Write a SQL query to list the years and the total sales for each year from the sales table, where thesales date is stored in sales_date.
select 
	year(sales_date) as years, sum(amount) as total_sales 
from
	sales
group by
	year(sales_date);

--  Q5.Write a query to find the employee(s) with the highest total salary in each department.
select employee_id, sum(salary) 
from 
	employees
group by 
	department_id; 
    
SELECT 
    e1.employee_id, 
    e1.department_id, 
    e1.salary
FROM 
    employees e1
WHERE 
    e1.salary = (
        SELECT 
            MAX(e2.salary)
        FROM 
            employees e2
        WHERE 
            e1.department_id = e2.department_id
    );






