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
SELECT s.product_id, year AS first_year,
quantity, price
FROM sales AS s
WHERE year in (SELECT MIN(year) FROM sales 
WHERE product_id = s.product_id
GROUP BY product_id)
-- bai 8 
SELECT DISTINCT customer_id FROM Customer AS c
WHERE 
(SELECT COUNT(customer_id) FROM Customer
WHERE customer_id = c.customer_id
GROUP BY customer_id) = (SELECT COUNT(product_key) FROM Product)
-- bai 9
SELECT e1.employee_id
FROM Employees e1
LEFT JOIN Employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000 AND e2.employee_id IS NULL AND e1.manager_id IS NOT NULL
ORDER BY employee_id;
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
WITH cte AS(SELECT requester_id id FROM RequestAccepted
UNION ALL
SELECT accepter_id id FROM RequestAccepted)
SELECT id, count(*) num  
FROM cte 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 1

