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

------ex5
SELECT candidate_id
FROM candidates 
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id ASC;
------ex6
SELECT card_name , MAX(issued_amount) - MIN(issued_amount) AS difference 
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;
 -----ex7
SELECT manufacturer,
COUNT(drug) AS drug_count, 
SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;
----ex8
SELECT *
FROM cinema
WHERE id % 2 <> 0 AND rating DESC;
---ex9
SELECT teacher_id, COUNT(DISTINCT subject_id) as cnt
FROM Teacher
GROUP BY teacher_id
---ex10
select user_id, count(follower_id) as followers_count
from followers
group by user_id
order by user_id
----ex11
select class from courses
group by class
having count(distinct student)>=5;
