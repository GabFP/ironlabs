SELECT customer.first_name, SUM(payment.amount) as total, ROUND(AVG(payment.amount), 2) as mean, COUNT(*) as frequen
FROM customer
INNER JOIN payment 
ON payment.customer_id = customer.customer_id
GROUP BY customer.first_name
ORDER BY total DESC;

/*Quem tem a maior frequencia e o maior valor gasto é o MARION */

SELECT customer.first_name, SUM(payment.amount) as total, ROUND(AVG(payment.amount), 2) as mean, COUNT(*) as frequen
FROM customer
INNER JOIN payment 
ON payment.customer_id = customer.customer_id
GROUP BY customer.first_name
ORDER BY mean DESC;

/*Quem tem a maior media é a BRITTANY*/

SELECT film.title, COUNT(*)
FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY COUNT(*) DESC
LIMIT 5;

/*----------------------------------*/

SELECT category.name , COUNT(*)
FROM category
JOIN film_category ON film_category.category_id = category.category_id
JOIN film ON film.film_id = film_category.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY category.name
ORDER BY COUNT(*) DESC

/*-------------------*/

SELECT customer.first_name , category.name,
SUM(payment.amount) as total, 
ROUND(AVG(payment.amount), 2) as mean, 
COUNT(*) as frequen
FROM category
JOIN film_category ON film_category.category_id = category.category_id
JOIN film ON film.film_id = film_category.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN customer ON customer.customer_id = rental.customer_id
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.first_name, category.name
ORDER BY total DESC
LIMIT 5


