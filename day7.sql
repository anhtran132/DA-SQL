-- bai 1
SELECT name FROM students
WHERE marks > 75
ORDER BY RIGHT(name, 3), id ;
-- bai 2 
SELECT user_id, CONCAT(UPPER(LEFT(name, 1)), LOWER(RIGHT(name, LENGTH(name) - 1))) as name FROM users;
-- bai 3
SELECT manufacturer, '$' || ROUND(SUM(total_sales)/1000000) || ' million' AS sales_mil FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY CEILING(SUM(total_sales)/1000000) DESC, manufacturer;
-- bai 4
SELECT product_id,
EXTRACT(month FROM submit_date) AS submit_month,
ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY submit_month, product_id
ORDER BY submit_month, product_id;
-- bai 5 
SELECT sender_id, COUNT(message_id) as message_count FROM messages
WHERE EXTRACT(year FROM sent_date) = '2022'
AND EXTRACT(month FROM sent_date) = '08'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
-- bai 6
SELECT tweet_id FROM tweets
WHERE LENGTH(content) > 15;
-- bai 7
# Write your MySQL query statement below
SELECT  activity_date as day, COUNT(DISTINCT user_id) AS active_users FROM activity 
WHERE activity_date BETWEEN '2019-06-27' AND '2019-07-27'
GROUP BY activity_date
-- bai 8
select id from employees
where EXTRACT(month FROM joining_date) IN ('01', '02', '03', '04', '05', '06', '07') AND EXTRACT(year FROM joining_date) = '2022';
-- bai 9
select POSITION('a' IN first_name) from worker
where first_name = 'Amitah';
-- bai 10 
select title, SUBSTRING(title, POSITION('2' IN title), 4) as year from winemag_p2
WHERE country = 'Macedonia';
