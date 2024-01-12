--------ex1 
select * from station
where mod(ID,2) = 0 ;
SELECT DISTINCT CITY FROM STATION WHERE MOD(ID,2)=0 ORDER BY CITY ASC;       
------ex2
SELECT (COUNT(city) - COUNT(DISTINCT city)) AS difference
FROM station;
------ex3
select ceil(avg(salary)-avg(replace(salary,0,''))) from EMPLOYEES;
------ex4
select sum(item_count * order_occurrences) as total_items;
sum(cast(order_occurrences as decimal)) as total orders
from items_per_order
------ex5
SELECT candidate_id
FROM candidates 
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id ASC;
-----ex6 
WITH UserPostCounts AS (
  SELECT user_id, 
         COUNT(*) AS post_count, 
         MIN(post_date) AS first_post_date, 
         MAX(post_date) AS last_post_date
    FROM posts
   WHERE YEAR(post_date) = 07/04/2021 12:00:00
GROUP BY user_id
HAVING COUNT(*) >= 2
)

SELECT user_id, 
       DATEDIFF(last_post_date, first_post_date) AS days_between
FROM UserPostCounts;
------ex7
SELECT card_name , MAX(issued_amount) - MIN(issued_amount) AS difference 
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;
 -----ex8
SELECT manufacturer,
COUNT(drug) AS drug_count, 
SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;
----ex9
SELECT *
FROM cinema
WHERE id % 2 <> 0 AND rating DESC;
---ex10
SELECT teacher_id, COUNT(DISTINCT subject_id) as cnt
FROM Teacher
GROUP BY teacher_id
---ex11
select user_id, count(follower_id) as followers_count
from followers
group by user_id
order by user_id
----ex12
select class from courses
group by class
having count(student)>=5;
