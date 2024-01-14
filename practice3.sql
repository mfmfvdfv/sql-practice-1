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
