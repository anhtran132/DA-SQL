-- bai 1
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
SELECT company_id, title, description, COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;
-- bai 2
(SELECT category, product, SUM(spend) AS total_spend FROM product_spend
WHERE EXTRACT(year FROM transaction_date) = '2022' AND category = 'appliance'
GROUP BY category, product
ORDER BY category, SUM(spend) DESC
LIMIT 2)
UNION ALL
(SELECT category, product, SUM(spend) AS total_spend FROM product_spend
WHERE EXTRACT(year FROM transaction_date) = '2022' AND category = 'electronics'
GROUP BY category, product
ORDER BY category, SUM(spend) DESC
LIMIT 2)
-- bai 3
SELECT COUNT(policy_holder_id) FROM
(SELECT policy_holder_id, COUNT(policy_holder_id) AS policy_holder_count  FROM callers
GROUP BY policy_holder_id
HAVING  COUNT(policy_holder_id) >= 3) AS t1
-- bai 4
SELECT p1.page_id FROM pages AS p1
LEFT JOIN page_likes AS p2 
ON p1.page_id = p2.page_id
WHERE liked_date IS NULL
ORDER BY page_id;
-- bai 5
SELECT EXTRACT(month FROM t1.event_date) as month, COUNT( DISTINCT t1.user_id) as monthly_active_users FROM 
(SELECT * FROM user_actions
WHERE event_type IN ('sign-in', 'like', 'comment') AND EXTRACT(month FROM event_date) = 7) as t1
INNER JOIN 
(SELECT * FROM user_actions
WHERE event_type IN ('sign-in', 'like', 'comment') AND EXTRACT(month FROM event_date) = 6) as t2
ON t1.user_id = t2.user_id
GROUP BY EXTRACT(month FROM t1.event_date)
-- bai 6
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(state) AS trans_count , 
(SELECT COUNT(state) FROM Transactions WHERE state = 'approved' AND id = t1.id
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country ) as approved_count, 
SUM(amount) AS trans_total_amount, 
(SELECT SUM(amount) FROM Transactions WHERE state = 'approved' AND id = t1.id
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country ) as approved_total_amount
FROM Transactions as t1
GROUP BY month, country;
-- bai 7
WITH min_year AS (SELECT MIN(year) as first_year FROM sales 
GROUP BY product_id)
SELECT product_id, year AS first_year, quantity, price FROM sales AS s
JOIN min_year AS m ON s.year = m.first_year
-- bai 8 
SELECT DISTINCT customer_id FROM customer
GROUP BY customer_id
HAVING COUNT(product_key) = (SELECT COUNT(*) FROM product)
-- bai 9
SELECT employee_id FROM employees
WHERE salary < 30000 AND
manager_id NOT IN (SELECT employee_id FROM employees)
-- bai 10
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
SELECT company_id, title, description, COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;
-- bai 11
(SELECT Users.Name as results
FROM Users JOIN MovieRating
ON Users.user_id = MovieRating.user_id
GROUP BY MovieRating.user_id
ORDER BY count(MovieRating.user_id) DESC, Users.Name ASC
LIMIT 1)
UNION ALL
(SELECT Movies.title as results
FROM Movies JOIN MovieRating
ON Movies.movie_id = MovieRating.movie_id
WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY MovieRating.movie_id
ORDER BY avg(MovieRating.rating) DESC, Movies.title ASC
LIMIT 1)
-- bai 12
WITH total_id AS
(SELECT requester_id As id FROM RequestAccepted
UNION ALL
SELECT accepter_id FROM RequestAccepted)
SELECT id, COUNT(id) as num FROM total_id
GROUP BY id
ORDER BY COUNT(id) DESC
LIMIT 1
