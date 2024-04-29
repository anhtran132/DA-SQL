-- bai 1
SELECT  DISTINCT city  FROM station
WHERE id%2 = 0;
-- bai 2
SELECT COUNT(city) - COUNT(DISTINCT city) AS difference FROM station;
-- bai 3
-- bai 4
SELECT ROUNd(SUM(order_occurrences * item_count)/SUM(order_occurrences), 1) as mean FROM items_per_order;
-- bai 5
SELECT candidate_id FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3;
-- bai 6
SELECT user_id, MAX(DATE(post_date)) - MIN(DATE(post_date)) AS days_between FROM posts
GROUP BY user_id
HAVING MAX(DATE(post_date)) - MIN(DATE(post_date)) > 0;
-- bai 7
SELECT DISTINCT card_name, MAX(issued_amount) - MIN(issued_amount)  AS difference FROM monthly_cards_issued
GROUP BY card_name;
-- bai 8
SELECT DISTINCT manufacturer, COUNT(drug), ABS(SUM(total_sales - cogs)) AS total_loss FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer 
ORDER BY total_loss DESC;
-- bai 9
SELECT * FROM cinema 
WHERE id%2 != 0 AND description != 'boring'
ORDER BY rating DESC;
-- bai 10
SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id;
-- bai 11
SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id;
-- bai 12
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) > 5;

