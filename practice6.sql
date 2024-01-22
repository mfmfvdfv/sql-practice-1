-----ex1 Active User Retention 
SELECT 
extract (month from curr_month.event_date) as month,
count(DISTINCT curr_month.user_id) as monthly_active_users
from user_actions as curr_month
where exists(
select last_month.user_id
from user_actions as last_month
WHERE last_month.user_id = curr_month.event_date
and extract (month from last_month.event_date)=
EXTRACT(month from curr_month.event_date - interval'1 month'))
and EXTRACT(month from curr_month.event_date) = 7
AND EXTRACT(year from curr_month.event_date) = 2022
group by EXTRACT(month from curr_month.event_date);

-----ex2 page without likes
SELECT p.page_id FROM pages p
LEFt join page_likes pl ON p.page_id=pl.page_id
WHERE liked_date is NULL
ORDER BY p.page_id

-----ex3 Patient Support Analysis
SELECT COUNT(sq.policy_holder_id) AS member_count
FROM(
SELECT policy_holder_id
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3 ) AS sq

-----ex4 Highest-Grossing Items [Amazon SQL Interview Question]
SELECT category, product FROM product_spend 
SUM(spend) AS total_spend, 
WHERE EXTRACT(year FROM transaction_date) = 2022
GROUP BY product, total_spend;

-----ex5 Duplicate Job Listings
WITH job_count_cte AS (
SELECT
company_id,
title,
description,
COUNT(job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description
)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;

----ex5 monthly transaction 
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS total_transactions,
    SUM(amount) AS total_amount,
    COUNT(CASE WHEN state = 'approved' THEN id END) AS approved_transactions,
    SUM(CASE WHEN state = 'approved' THEN amount END) AS approved_amount
FROM
    Transactions
GROUP BY
    month, country;
-------product sales
-------Sales=s
SELECT
    s.product_id,
    s.year,
    s.quantity,
    s.price
FROM
    Sales s
JOIN
    (
        SELECT
            product_id,
            MIN(year) AS first_year
        FROM
            Sales
        GROUP BY
            product_id
    ) first_years ON s.product_id = first_years.product_id AND s.year = first_years.first_year;

----customer who bought all products
SELECT
    customer_id
FROM
    Customer
GROUP BY
    customer_id
HAVING
    COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);

-----manager left the company
SELECT
    e.employee_id
FROM
    Employees e
LEFT JOIN
    Employees m ON e.manager_id = m.employee_id
WHERE
    e.salary < 30000
    AND m.employee_id IS NULL
ORDER BY
    e.employee_id;

----moving rating
WITH UserMovieCount AS (
    SELECT
        u.user_id,
        u.name,
        COUNT(r.movie_id) AS movie_count
    FROM
        Users u
    LEFT JOIN
        MovieRating r ON u.user_id = r.user_id
    GROUP BY
        u.user_id, u.name
),
TopUser AS (
    SELECT
        user_id,
        name
    FROM
        UserMovieCount
    ORDER BY
        movie_count DESC, name
    LIMIT 1
),
TopMovie AS (
    SELECT
        m.title
    FROM
        Movies m
    JOIN
        MovieRating r ON m.movie_id = r.movie_id
    WHERE
        r.created_at >= '2020-02-01' AND r.created_at < '2020-03-01'
    GROUP BY
        m.title
    ORDER BY
        AVG(r.rating) DESC, m.title
    LIMIT 1
)

SELECT
    (SELECT name FROM TopUser) AS top_user,
    (SELECT title FROM TopMovie) AS top_movie;
--who have the most friend
SELECT
    user_id,
    COUNT(DISTINCT friend_id) AS num_friends
FROM
    (
        SELECT
            requester_id AS user_id,
            accepter_id AS friend_id
        FROM
            RequestAccepted
        UNION ALL
        SELECT
            accepter_id AS user_id,
            requester_id AS friend_id
        FROM
            RequestAccepted
    ) Friends
GROUP BY
    user_id
ORDER BY
    num_friends DESC, user_id
LIMIT 1;

