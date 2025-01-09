use sakila;

DELIMITER //
create procedure proce_amount2( IN pid int)
begin
	declare v_amount double(6,2);
    select amount into v_amount from payment
    where payment_id = pid;
    select v_amount;
end //
DELIMITER ;

call proce_amount2(162);

-- droping procedure
drop procedure proce_amount2;



DELIMITER //
create procedure proce_firstLastName( in pid int)
begin
	declare firstName (20);
    declare lastName (20);
    select first_name , last_name into first_name, lastName from payment
    where payment_id = pid;
    select v_amount;
end //
DELIMITER ;


-- take a payment id from the user and get the amount into the salary column

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