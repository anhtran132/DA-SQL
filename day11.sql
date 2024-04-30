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
HAVING COUNT(DISTINCT p.product_category) = 3;
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
