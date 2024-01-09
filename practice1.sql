-----a "query" refers to a request for data or information from a database
---ex1
SELECT NAME FROM CITY
WHERE CountryCode = 'USA' AND Population > 120000;
----ex2
Select * from city 
where countrycode = 'JPN' ;
----ex3
select city , state from station ;
----ex4
select * from station
where city like 'a%' or 'e%' or 'i%' or 'u%' or 'o%' ;
----ex5- can not run successful 
select * from station
where distinct city like '%a' or '%e' or '%i' or '%u' ;
------
select city from station
where distinct city like '%a' or '%e' or '%i' or '%u' ;
------
SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';
----ex6, city is string varchar2 so use REGEXP 
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]';
-----ex7
SELECT name FROM employee ORDER BY name ASC;
-----ex8 not right  
SELECT employee_id and name and salary 
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;
-----
SELECT employee_id , name , salary 
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;
----ex9 both low fat and recyclable
select product_id
from products
where products . low_fats = "Y" and products . recyclable = "Y"
----ex10
# Write your MySQL query statement below
SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id is NULL;
----ex11
select name, population,area from world
where area >= 3000000 or population >= 25000000 ;
----ex12
select author_id, article_id, view_date from views 
where view_date >= 1 ;
---ex13 
SELECT * FROM parts_assembly
WHERE finish_date is NULL;
---ex14 
select * from lyft_drivers
where yearly_salary <=30000 or >=70000;
---ex15 
select * from uber_advertising 
where money_spent >100000 ;
