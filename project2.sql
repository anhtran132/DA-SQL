-- Phan 1
-- bai 1 : Số lượng khách hàng + số lượng order tăng theo từng tháng của các năm, không có dấu hiệu sụt giảm
SELECT FORMAT_DATE('%Y-%m', created_at) as date, COUNT(order_id) as total_orde, COUNT(user_id) as total_user FROM bigquery-public-data.thelook_ecommerce.orders 
WHERE status = 'Shipped' AND FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01' AND '2022-04'
GROUP BY 1
ORDER BY 1
-- bai 2 :Trong năm 2019, giá trị trung bình các đơn hàng của tháng có sự tăng giảm thất thường. 
-- Từ năm 2020 đến năm 2022, giá trị trung bình luôn giao động nhẹ trong khoảng 54 đến 62 cho mỗi đặt hàng của khách.
SELECT FORMAT_DATE('%Y-%m', o1.created_at) as date, COUNT(DISTINCT o1.user_id) as distinct_users, SUM(o2.sale_price)/COUNT(o1.order_id) as average_order_value 
FROM bigquery-public-data.thelook_ecommerce.orders as o1
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items as o2 ON o1.order_id = o2.order_id
WHERE o1.status = 'Shipped' AND FORMAT_DATE('%Y-%m', o1.created_at) BETWEEN '2019-01' AND '2022-04'
GROUP BY 1
ORDER BY 1
-- bai 3 KH trẻ tuổi nhất là 12 tuổi số lượng là 1010. KH lớn tuổi nhất là 70 tuổi, số lượng là 993
CREATE TEMP TABLE customer_data AS
SELECT * FROM 
(SELECT first_name, last_name, gender, age, 'youngest' as tag FROM bigquery-public-data.thelook_ecommerce.users
WHERE age = (SELECT min(age) FROM bigquery-public-data.thelook_ecommerce.users) AND FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01' AND '2022-04'
UNION ALL
SELECT first_name, last_name, gender, age , 'oldest' as tag FROM bigquery-public-data.thelook_ecommerce.users
WHERE age = (SELECT max(age) FROM bigquery-public-data.thelook_ecommerce.users) AND FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01' AND '2022-04')

SELECT COUNT(age) FROM my-project-2-422915._b9aae6f1946c2ef70383046ee451c3079ccba7f8._b4e6d28e_8cf9_47d0_817f_f50dd4963832_customer_data
WHERE age = (SELECT min(age) FROM bigquery-public-data.thelook_ecommerce.users)
SELECT COUNT(age) FROM my-project-2-422915._b9aae6f1946c2ef70383046ee451c3079ccba7f8._b4e6d28e_8cf9_47d0_817f_f50dd4963832_customer_data
WHERE age = (SELECT max(age) FROM bigquery-public-data.thelook_ecommerce.users)
-- bai 4
SELECT * FROM (WITH cte AS(SELECT FORMAT_DATE('%Y-%m', o.delivered_at) as date, p.id, p.name, 
ROUND(SUM(p.cost)) as cost, 
ROUND(SUM(o.sale_price)) as sales,
ROUND(SUM(o.sale_price - p.cost)) as profit,
FROM bigquery-public-data.thelook_ecommerce.products as p 
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items as o ON p.id = o.product_id
WHERE o.status = 'Complete'
GROUP BY 1,2,3
ORDER BY 1)
SELECT *,
DENSE_RANK() OVER(PARTITION BY date ORDER BY profit DESC) as rank_per_month
FROM cte) 
WHERE rank_per_month < 6
ORDER BY date
-- bai 5
SELECT FORMAT_DATE('%Y-%m-%d', o.delivered_at) as date,
p.category, ROUND(SUM(o.sale_price)) as revenue
FROM bigquery-public-data.thelook_ecommerce.order_items as o
INNER JOIN bigquery-public-data.thelook_ecommerce.products as p ON o.product_id = p.id
WHERE FORMAT_DATE('%Y-%m-%d', o.delivered_at) BETWEEN '2022-04-15' AND '2022-07-15' AND o.status = 'Complete'
GROUP BY FORMAT_DATE('%Y-%m-%d', o.delivered_at), p.category
ORDER BY 1
-- Phan 2  
-- bai 1
WITH cte as (SELECT FORMAT_DATE('%Y-%m', o1.delivered_at) as month, 
FORMAT_DATE('%Y', o1.delivered_at) as year,
SUM(o2.sale_price) as tpv,
COUNT(o2.order_id) as tpo, 
SUM(p.cost) as total_cost,
FROM bigquery-public-data.thelook_ecommerce.orders as o1
JOIN bigquery-public-data.thelook_ecommerce.order_items as o2 ON o1.order_id = o2.order_id
JOIN bigquery-public-data.thelook_ecommerce.products as p ON o2.product_id = p.id
WHERE o2.status = 'Complete'
GROUP BY 1,2
ORDER BY 1)

CREATE VIEW vw_ecommerce_analyst AS
SELECT *,
ROUND((LEAD(tpv) OVER(ORDER BY month, year)  - tpv)/tpv, 3) || '%' as revenue_growth,
ROUND((LEAD(tpo) OVER(ORDER BY month, year)  - tpo)/tpo, 3) || '%' as order_growth,
ROUND(tpv-total_cost,2) as total_profit,
ROUND(ROUND(tpv-total_cost,2)/total_cost, 2) || '%' as profit_to_cost_ratio 
FROM cte
ORDER BY month, year
-- bai 2
WITH cte AS 
(SELECT *
FROM bigquery-public-data.thelook_ecommerce.order_items
WHERE delivered_at IS NOT NULL),
cte2 AS (SELECT 
user_id,
sale_price,
FORMAT_DATE('%Y-%m', first_purchase_date) as cohort_date,
(EXTRACT(year FROM delivered_at) - EXTRACT(year FROM first_purchase_date))*12
+ (EXTRACT(month FROM delivered_at) - EXTRACT(month FROM first_purchase_date)) + 1 as index
FROM (SELECT user_id, sale_price,
MIN(delivered_at) OVER(PARTITION BY user_id) as first_purchase_date,
delivered_at
FROM cte)
), 
cte3 AS (
SELECT 
cohort_date, index, 
COUNT(DISTINCT user_id) as users,
SUM(sale_price) as revenue
FROM cte2
WHERE cohort_date BETWEEN '2020-09' AND '2020-11' AND index < 5
GROUP BY cohort_date, index
ORDER BY cohort_date, index),
user_cohort AS (
SELECT 
cohort_date,
SUM(case when index = 1 then users else 0 end) as m1,
SUM(case when index = 2 then users else 0 end) as m2,
SUM(case when index = 3 then users else 0 end) as m3,
SUM(case when index = 4 then users else 0 end) as m4,
FROM cte3
GROUP BY cohort_date
)
SELECT 
cohort_date,
ROUND(100.00 *m1/m1) || '%' as m1,
ROUND(100.00 *m2/m1) || '%' as m2,
ROUND(100.00 *m3/m1) || '%' as m3,
ROUND(100.00 *m4/m1) || '%' as m4
FROM user_cohort




