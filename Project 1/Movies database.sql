use mavenmovies;

----------------
-- question 1 --
----------------
-- 1. write a SQL query to count the number of characters except for the spaces for each actor --
-- Return the first 10 actors name length along with their names; --

select first_name, last_name,
length(first_name)+length(last_name) as name_length from actor
order by first_name desc                                            -- order will always come before and not after --
limit 10;


-- here, since there we no spaces present anyways, we can simply use the above query in case of present spaces we could've just used --
-- replace function to replace spaces with no spaces and then perform the above query --

----------------
-- question 2 --
----------------
-- 2. list all oscar awardees(actors who received the oscar awards) with their full names and the length of their names --

select first_name, last_name,
length(first_name)+length(last_name) as name_length from actor_award
where awards like '%oscar%';

-- here I've use '%' to make sure that the compiler also scans oscar even if its among different awards --

----------------
-- question 3 --
----------------
-- find the actor who acted in the movie 'Frost head' --

select first_name, last_name from actor as a
inner join film_actor as fa
on a.actor_id = fa.actor_id
inner join film as f
on fa.film_id = f.film_id
where title = 'frost head';

-- a question similar to another quetion from another assignment( q1 ) , just rename the titles and you're good to go --

----------------
-- question 4 --
----------------
-- pull all the films acted by the actor 'Will Wilson' --

select title as Will_Wilson_Movies from film as t_film
inner join film_actor as fa
on t_film.film_id = fa.film_id
inner join actor as ac
on fa.actor_id = ac.actor_id
where first_name = 'Will' and last_name = 'Wilson';

----------------
-- question 5 --
----------------
-- Pull all the films which rented and returned in the month of May -- 

select title as Movies_of_may from rental r 
inner join inventory as inv	
on r.inventory_id = inv.inventory_id
inner join film as fl
on inv.film_id = fl.film_id
where rental_date like '_____05____________' and return_date like '_____05____________';

----------------
-- question 6 --
----------------
-- Pull all the films with 'comedy' category -- 

select title as Comedy_films from film as f
inner join film_category as fc
on f.film_id = fc.film_id
inner join category as c
on fc.category_id = c.category_id
where name = 'comedy';