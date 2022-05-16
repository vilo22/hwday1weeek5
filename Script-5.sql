--1. List all customers who live in Texas (use
--JOINs)

select * from customer;
select * from address;
select customer.first_name, address.district  
from customer
join  address 
on customer.address_id = address.address_id
where address.district like 'Texas' ; 


--2. Get all payments above $6.99 with the Customer's Full Name

select * from customer; -- here you select first and last name, here you use customer ID to join everything
select * from payment; --here you use amount to get all payments . 6.99 use customer ID to join everything

select customer.first_name, customer.last_name, payment.amount
from customer 
join payment
on customer.customer_id = payment.customer_id  
where payment.amount  > 6.99;

--3. Show all customers names who have made payments over $175(use
--subqueries)

select first_name
from customer 
where customer_id in( 
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount) > 175
);

--4. List all customers that live in Nepal (use the city
--table)
select customer.first_name, country.country 
from customer 
join address
on address.address_id = customer.address_id 
join city
on address.city_id = city.city_id 
join country
on country.country_id = city.country_id
where country.country like 'Nepal';

--Aparently just kevin
--5. Which staff member had the most
--transactions?

select * from staff; --Use the staff id to conect to payments
select * from payment; -- after joining the table try to count the amount of payment_id by staff

select staff.first_name, count(payment.staff_id) 
from staff 
join payment 
on payment.staff_id = staff.staff_id
group by staff.first_name , payment.staff_id 
order by count(payment.staff_id) desc ;
-- Jon has the most transactions(7,304)

--6. How many movies of each rating are there?
select * from film;

select rating, count(rating)
from film 
group by rating, rating
order by count(rating) desc;

-- there are 5 223 PG-13 movies, 209 NC-17 movies, 195 R movies, 194 PG movies and 179 G movies. 

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select * from payment;

select customer_id, first_name, last_name
from customer
where customer_id in(
	select customer_id 
	from payment
	group by customer_id 
	having sum(amount) > 6.99 
);

--8. How many free rentals did ourstores give away?
select * from film;
select * from payment;

select film.film_id , film.title
from film
join inventory
on film.film_id = inventory.film_id
join rental
on inventory.inventory_id = rental.inventory_id 
join payment 
on rental.rental_id = payment.rental_id
where payment.amount = 0;

-- 23 movies were given for free
