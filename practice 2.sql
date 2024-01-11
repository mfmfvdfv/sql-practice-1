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
