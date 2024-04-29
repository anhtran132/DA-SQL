-- baitap1
SELECT name FROM CITY
WHERE population > 120000 AND countrycode = 'USA';
-- baitap2
SELECT * FROM CITY 
WHERE countrycode = 'JPN';
-- baitap3
SELECT city,state FROM STATION;
-- baitap4
SELECT DISTINCT city FROM STATION
WHERE city LIKE 'a%' OR city LIKE 'e%' OR city LIKE 'i%' OR city LIKE 'o%' OR city LIKE 'u%';
-- baitap5
SELECT DISTINCT city FROM STATION
WHERE city LIKE '%a' OR city LIKE '%e' OR city LIKE '%i' OR city LIKE '%o' OR city LIKE '%u';
-- baitap6
SELECT DISTINCT city FROM STATION
WHERE city NOT LIKE 'a%' AND  city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'o%' AND city NOT LIKE 'u%';
-- baitap7
SELECT name FROM Employee
ORDER BY name;
-- baitap8
SELECT name FROM Employee
WHERE salary > 2000 AND months <10
ORDER BY employee_id;
-- baitap9
SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
-- baitap10
SELECT name FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;
-- baitap11
SELECT name, population, area FROM World
WHERE area >= 3000000 OR population >= 25000000;
-- baitap12 
SELECT DISTINCT author_id AS id FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
-- baitap13
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;
-- baitap14
select * from uber_advertising
where money_spent > 100000 and year = '2019';
