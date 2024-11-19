USE sakila;
/*## Challenge - Joining on multiple tables

Write SQL queries to perform the following tasks using the Sakila database:

1. List the number of films per category.*/

SELECT category.name AS category_name, COUNT(*) AS number_of_films
FROM category
JOIN film_category
USING (category_id) 
GROUP BY category_name
ORDER BY number_of_films DESC;

/*2. Retrieve the store ID, city, and country for each store.*/

SELECT store_id, city, country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING ( country_id)
;

/*3.  Calculate the total revenue generated by each store in dollars.*/

SELECT store.store_id, SUM(payment.amount) AS total_revenue_generated
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON payment.staff_id = store.store_id
GROUP BY store.store_id;

/*4.  Determine the average running time of films for each category.*/

SELECT name, AVG(length) AS avg_running_time
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
GROUP BY name;

/***Bonus**:

5.  Identify the film categories with the longest average running time.*/

SELECT name, AVG(length) AS avg_running_time
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
GROUP BY name
ORDER BY avg_running_time DESC
LIMIT 1;

/*6.  Display the top 10 most frequently rented movies in descending order.*/

SELECT title, COUNT(rental_id) AS number_of_rental
FROM film
LEFT JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY title
ORDER BY  number_of_rental DESC
LIMIT 10;

/*7. Determine if "Academy Dinosaur" can be rented from Store 1.*/

SELECT COUNT(*) AS number_of_films, title
FROM film
JOIN inventory USING (film_id)
JOIN store USING (store_id)
WHERE title = "Academy Dinosaur" AND store_id = 1
;

/*8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a `CASE` statement combined with `IFNULL`."*/

SELECT DISTINCT title,
	CASE
		WHEN COUNT(inventory.inventory_id) >0 THEN "Available"
		ELSE "Not Available"
	END AS availability_status
FROM film
LEFT JOIN inventory USING (film_id)
GROUP BY film.title
ORDER BY film.title ASC
;