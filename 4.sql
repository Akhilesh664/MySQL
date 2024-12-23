use employees;
select * from sakila.payment;

select max(amount) from sakila.payment;
select max(amount) from sakila.payment where amount < 11.99;

