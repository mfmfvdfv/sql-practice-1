-----STUDENTS who scored higher than 75  Marks
select name from STUDENTS where marks > 75 order by right(name, 3), ID ASC;
-------------fix the names
select user_id,
CONCAT(UPPER(SUBSTRING(name,1,1)),LOWER(SUBSTRING(name,2))) as name from users 
order by user_id asc
----------Pharmacy Analytics (Part 3) 1000000 because it is million
SELECT 
    manufacturer,
    CONCAT('$',ROUND(SUM(total_sales)/1000000),' million') AS total_sales
FROM Pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC , manufacturer;
---------------Average Review Ratings [Amazon SQL Interview Question]
SELECT
    EXTRACT(MONTH FROM submit_date) AS month,
    product_id,
    ROUND(AVG(stars), 2) AS average_star_rating
FROM
    reviews
GROUP BY
    EXTRACT(MONTH FROM submit_date),
    product_id
ORDER BY
    EXTRACT(MONTH FROM submit_date),
    product_id;
----------------Teams Power Users [Microsoft SQL Interview Question]
SELECT
    sender_id,
    SUM(message_id) AS total_messages
FROM
    messages
WHERE
    EXTRACT(MONTH FROM sent_date) = 8 -- August
    AND EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY
    sender_id
ORDER BY
    total_messages DESC
LIMIT 2;
-----------------Write a solution to find the IDs of the invalid tweets
select tweet_id  from Tweets; 
where length(content)>15;
---------------- 
SELECT COUNT(*) AS hired_employees_count
FROM employees
WHERE YEAR(hire_date) = 2022
  AND MONTH(hire_date) BETWEEN 1 AND 7;
------------------------
SELECT POSITION('a' IN LOWER(first_name)) AS position_of_a
FROM worker
WHERE LOWER(first_name) = 'amitah';
----------------
SELECT
    title,
    CAST(SUBSTRING(title FROM '[0-9]+') AS INT) AS vintage_year
FROM
    winemag_p2
WHERE
    LOWER(title) LIKE '%macedonia%';
-------------------
SELECT
    CASE
        WHEN pclass = 1 THEN 'first_class'
        WHEN pclass = 2 THEN 'second_class'
        WHEN pclass = 3 THEN 'third_class'
        ELSE 'unknown_class'
    END AS passenger_class,
    COUNT(*) AS total_passengers,
    SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS survivors,
    SUM(CASE WHEN survived = 0 THEN 1 ELSE 0 END) AS non_survivors
FROM
    titanic
GROUP BY
    passenger_class
ORDER BY
    passenger_class;
-------------- Find the names of the customer
SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id is NULL;
-----------Patient Support Analysis (Part 2) [UnitedHealth SQL Interview Question]
SELECT
    ROUND((SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 ELSE 0 END) / COUNT(*)) * 100,1) AS call_percentage
FROM callers;
------------
SELECT
 SUM(CASE
   WHEN DEVICE_TYPE = 'tablet' OR DEVICE_TYPE = 'phone' 
   THEN 1 ELSE 0 END) AS MOBILE_VIEWS,
 SUM(CASE
   WHEN DEVICE_TYPE = 'laptop'
   THEN 1 ELSE 0 END) AS LAPTOP_VIEWS
FROM
 VIEWERSHIP;
-----------
SELECT x, y, z,
    CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No'
    END AS triangle
FROM
    triangle;

