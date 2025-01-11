
-- [ INDEX ]
-- reference table
-- query fast execute hoti hai

-- Indexes => are special lookup tables that need to be used by the database search engine to speed up 
-- data retrieval. An index is simply a reference to data in a table. A database index is similar to 
-- the index in the back of a journal. It cannot be viewed by the users and just used to speed up the database access

use regex1;

CREATE TABLE employees (
    employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    device_serial varchar(15),
    salary int
);

INSERT INTO employees VALUES
    (1, 'John', 'Smith', 'ABC123', 60000),
    (2, 'Jane', 'Doe', 'DEF456', 65000),
    (3, 'Bob', 'Johnson', 'GHI789', 70000),
    (4, 'Sally', 'Fields', 'JKL012', 75000),
    (5, 'Michael', 'Smith', 'MNO345', 80000),
    (6, 'Emily', 'Jones', 'PQR678', 85000),
    (7, 'David', 'Williams', 'STU901', 90000),
    (8, 'Sarah', 'Johnson', 'VWX234', 95000),
    (9, 'James', 'Brown', 'YZA567', 100000),
    (10, 'Emma', 'Miller', 'BCD890', 105000),
    (11, 'William', 'Davis', 'EFG123', 110000),
    (12, 'Olivia', 'Garcia', 'HIJ456', 115000),
    (13, 'Christopher', 'Rodriguez', 'KLM789', 120000),
    (14, 'Isabella', 'Wilson', 'NOP012', 125000),
    (15, 'Matthew', 'Martinez', 'QRS345', 130000),
    (16, 'Sophia', 'Anderson', 'TUV678', 135000),
    (17, 'Daniel', 'Smith', 'WXY901', 140000),
    (18, 'Mia', 'Thomas', 'ZAB234', 145000),
    (19, 'Joseph', 'Hernandez', 'CDE567', 150000),
    (20, 'Abigail', 'Smith', 'FGH890', 155000);
    

select * from employees;

-- explain show all data how much line of data it search etc.
explain select * from employees where salary =100000;

-- indexing
create index emp_sal on employees(salary);
desc employees;
explain select * from employees where salary =100000;

explain select * from employees where salary =100000 or first_name='james'; -- composite index

show indexes from employees;  
drop index emp_sal on employees;
show indexes from employees;

-- cardinality mean unique data in table 
update employees set first_name = 'John' where employee_id = 3;
create index emp_sal_f on employees(salary, first_name);
show indexes from employees;
analyze table employees;


-- ===================================
-- Window function
select * from employees;
select first_name, sum(salary) from employees; -- no result because agregate function used in individual data

select first_name, sum(salary) 
over() from employees; -- no result because agregate function used in individual data

select first_name, sum(salary) 
over(partition by first_name) from employees; -- no result because agregate function used in individual data

select first_name, sum(salary) 
over(partition by first_name order by salary desc) from employees; -- no result because agregate function used in individual data

select first_name, salary, sum(salary) 
over(partition by first_name),
rank() over(partition by first_name order by salary desc) from employees; -- no result because agregate function used in individual data

with cte as 
(select first_name, salary, 
sum(salary) over(partition by first_name),
rank() over(partition by first_name order by salary desc) as r1 
from employees) -- no result because agregate function used in individual data
select * from cte where r1 =2;


select * from 
(select first_name, salary, 
sum(salary) over(partition by first_name),
rank() over(partition by first_name order by salary desc) as r1 
from employees)as tab1;
 
 
-- ===================================

-- Stored Procedure
-- Procedure => A stored procedure in SQL is a group of SQL statements that are stored 
-- together in a database. Based on the statements in the procedure and the parameters you pass, 
-- it can perform one or multiple DML operations on the database, and return value, if any.

use sakila;

-- procedure
DELIMITER $$
create procedure getActor()
begin
	select * from actor order by last_name;
end $$
DELIMITER ;

-- calling procedure 
call getActor();

-- ======== 
-- delimiter
-- declare
-- begin
-- end

DELIMITER //
create procedure proce_Amount()
begin
	declare v_amount double(6,2);
	select amount into v_amount from payment 
		where payment_id = 3;
    select v_amount;
end //
DELIMITER ;

-- dropping procedure
drop procedure proce_Amount;

-- calling procedure
call proce_Amount();

-- =====================

-- [ IN ] 
DELIMITER //
create procedure proce_amount2( IN pid int)
begin
	declare v_amount double(6,2);
    select amount into v_amount from payment
    where payment_id = pid;
    select v_amount;
end //
DELIMITER ;

call proce_amount2(3);

-- droping procedure
drop procedure proce_amount2;


-- ===============
use sakila;
select * from actor;

DELIMITER //
create procedure getfullActorName(IN aid int)
begin
	select first_name, last_name from actor
    where actor_id = aid;
end //
DELIMITER ;


drop procedure getfullActorName;
call getfullActorName(3);



-- take a payment id from the user and get the amount into the salary column[ IN and OUT ]

DELIMITER //
create procedure salaryUpdation(in pid int)
begin
    declare update_amount decimal(8, 1);

    select amount into update_amount
    from payment
    where (payment_id = pid);
    
    update employees
    set salary = update_amount
    where id = pid;
end //
DELIMITER ;

drop procedure salaryUpdation;
call salaryUpdation(7);

-- ==================

select * from employees;


delimiter //

create procedure salaryupdation(in pid int)
begin
    declare update_amount decimal(10, 2);

    select amount 
    into update_amount
    from payment
    where payment_id = pid;

    update employees
    set salary = update_amount
    where id = pid;
end //
delimiter ;

drop procedure salaryUpdation;
call salaryUpdation(7);

select * from employees;


-- take the actor id from the user into variable call ids and return total no. of movies done by that actor. 

delimiter //

create procedure GetTheActorMovieCount(
    in actor_id int,
    out movie_count int
)
begin
    declare countMovie int;

    select count(film.film_id)
    into countMovie
    from film_actor
    inner join film on film_actor.film_id = film.film_id
    where film_actor.actor_id = actor_id;

    -- Return the count of movies to the OUT parameter
    set movie_count = countMovie;
end //

delimiter ;

-- To call the procedure and get the result
-- First, declare a variable to hold the result
set @movie_count = 0;

call GetTheActorMovieCount(23, @movie_count);