-- bai 1
SELECT EXTRACT(YEAR FROM transaction_date) as year, product_id, spend,
LAG(spend) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend,
ROUND((spend - LAG(spend) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)))/
LAG(spend) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))*100, 2) AS yoy_rate
FROM user_transactions
ORDER BY product_id, year;
-- bai 2
WITH firstmonth AS (
SELECT card_name, issued_amount, 
ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS issue_order
FROM monthly_cards_issued
)
SELECT card_name, issued_amount
FROM firstmonth 
WHERE issue_order=1
ORDER BY issued_amount DESC ;
-- bai 3
WITH temp_table AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rank_trans
FROM transactions)
SELECT user_id, spend, transaction_date
FROM temp_table
WHERE rank_trans = 3
-- bai 4
WITH temp_table AS (
SELECT transaction_date, user_id, 
COUNT(product_id) OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS purchase_count,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as transaction_rank
FROM user_transactions
)
SELECT transaction_date, user_id, purchase_count
FROM temp_table
WHERE transaction_rank = 1
ORDER BY transaction_date
-- bai 5
-- bai 6
WITH delta_t_cte AS
(SELECT *,
EXTRACT(epoch FROM (transaction_timestamp-
LAG(transaction_timestamp) OVER(PARTITION BY merchant_id,credit_card_id, amount ORDER BY transaction_timestamp)))/60 as delta_t
FROM transactions)
SELECT
COUNT(delta_t) as payment_count
FROM delta_t_cte
WHERE delta_t <= 10
-- bai 7
WITH ranked_spending_cte AS (
SELECT category, product, SUM(spend) AS total_spend,
RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking 
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product
)
SELECT category, product, total_spend 
FROM ranked_spending_cte 
WHERE ranking <= 2 
ORDER BY category, ranking;
-- bai 8
WITH temp_table AS (
SELECT artists.artist_name,
DENSE_RANK() OVER (ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
FROM artists
INNER JOIN songs
ON artists.artist_id = songs.artist_id
INNER JOIN global_song_rank AS r
ON songs.song_id = r.song_id
WHERE r.rank <= 10
GROUP BY artists.artist_name
)
SELECT artist_name, artist_rank
FROM temp_table
WHERE artist_rank <= 5;

