-- bai 1
SELECT c2.continent, ROUND(AVG(c1.population)) FROM city AS c1
INNER JOIN country AS c2
ON c1.countrycode = c2.code
GROUP  BY c2.continent
ORDER BY  ROUND(AVG(c1.population));
-- bai 2
SELECT ROUND(CAST(COUNT(texts.email_id) AS decimal)/COUNT(DISTINCT emails.email_id), 2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
-- bai 3
SELECT age_bucket,
ROUND(SUM(CASE 
  WHEN activity_type = 'send' THEN time_spent ELSE 0
END)/SUM(time_spent)*100.0, 2) AS send_perc ,
ROUND(SUM(CASE 
  WHEN activity_type = 'open' THEN time_spent ELSE 0
END)/SUM(time_spent)*100.0, 2) AS open_perc
FROM activities as a1
INNER JOIN age_breakdown AS a2
ON a1.user_id = a2.user_id 
AND activity_type IN ('open', 'send')
GROUP BY age_bucket
-- bai 4 
SELECT customer_id
FROM customer_contracts as c
INNER JOIN products as p
ON c.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);
-- bai 5
SELECT e.employee_id, e.name, COUNT(m.employee_id) AS reports_count, ROUND(AVG(m.age)) AS average_age
FROM Employees AS e
LEFT JOIN Employees AS m
ON e.employee_id = m.reports_to
WHERE m.reports_to IS NOT NULL
GROUP BY employee_id
-- bai 6
# Write your MySQL query statement below
SELECT p.product_name, SUM(unit) as unit FROM Products AS p
LEFT JOIN Orders AS o
ON p.product_id = o.product_id
WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING unit >= 100
-- bai 7
SELECT p1.page_id FROM pages AS p1
LEFT JOIN page_likes AS p2 
ON p1.page_id = p2.page_id
WHERE liked_date IS NULL
ORDER BY page_id;
-- MID COURSE TEST
-- bai 1
SELECT min(replacement_cost) FROM film;
-- bai 2
SELECT 
COUNT(CASE
	WHEN replacement_cost >= 9.99 AND replacement_cost <= 19.99 THEN 'low' 
END) 
FROM film
-- bai 3
SELECT f.title, f.length, c.name as category_name FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id
WHERE c.name IN ('Drama', 'Sports')
ORDER BY  f.length DESC 
LIMIT 1;
-- bai 4SELECT c.name as category_name, COUNT(f.title) FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY COUNT(f.title) DESC
LIMIT 1;SELECT a.first_name || ' ' || a.last_name AS name, COUNT(f.film_id)
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
INNER JOIN actor AS a
ON a.actor_id = fa.actor_id
GROUP BY name
ORDER BY COUNT(f.film_id) DESC
LIMIT 1;
-- bai 5
SELECT a.first_name || ' ' || a.last_name AS name, COUNT(f.film_id)
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
INNER JOIN actor AS a
ON a.actor_id = fa.actor_id
GROUP BY name
ORDER BY COUNT(f.film_id) DESC
LIMIT 1;
-- bai 6
SELECT COUNT(a.address_id) FROM address AS a
LEFT JOIN customer AS c
ON c.address_id = a.address_id
WHERE c.customer_id IS NULL
-- bai 7
SELECT city.city, SUM(p.amount) FROM payment AS p
INNER JOIN customer AS cSELECT city.city, SUM(p.amount) FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id= c.customer_id
INNER JOIN address AS a
ON a.address_id = c.address_id
INNER JOIN city AS city 
ON city.city_id = a.city_id
GROUP BY city.city
ORDER BY SUM(p.amount) DESC
LIMIT 1;
-- bai 8
SELECT co.country, city.city, SUM(p.amount) FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id= c.customer_id
INNER JOIN address AS a
ON a.address_id = c.address_id
INNER JOIN city AS city 
ON city.city_id = a.city_id
INNER JOIN country AS co
ON co.country_id = city.country_id
GROUP BY co.country, city.city
ORDER BY SUM(p.amount) DESC
LIMIT 1;




























