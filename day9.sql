-- bai 1
SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views 
FROM viewership;
-- bai 2
SELECT x, y, z,
CASE    
    WHEN x + y > z AND x + z > y AND z + y > x THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM triangle;
-- bai 3
SELECT 
ROUND(CAST(SUM(CASE
  WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 ELSE 0
END) AS DECIMAL)/COUNT(*)*100, 1) as uncategorised_call_pct
FROM callers
-- bai 4
SELECT name FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;
-- bai 5
select survived, 
SUM(CASE
 WHEN pclass = 1 THEN 1 ELSE 0
END) as first_class,
SUM(CASE
 WHEN pclass = 2 THEN 1 ELSE 0
END) as second_class,
SUM(CASE
 WHEN pclass = 3 THEN 1 ELSE 0
END) as third_class
from titanic
GROUP BY survived;
