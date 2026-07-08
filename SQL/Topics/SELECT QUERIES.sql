--This is comment
/* welcome to me */


--Retrieve all customer data

SELECT * 
FROM  customers;

--Retrieve all ORDERS data

SELECT * 
FROM  orders; 

--task 1

SELECT first_name,country,score
FROM customers;

--task 2
SELECT * 
FROM customers
where score !=0;


Select * 
From customers
where country = 'Germany';

--task 3
SELECT *
FROM customers
ORDER BY  SCORE DESC;

--country ASC,

SELECT *
FROM customers
ORDER BY SCORE ASC;

SELECT COUNTRY,
       SUM(SCORE)   AS SUM_SCORE     
FROM customers
GROUP BY country;

--TASK 4
SELECT COUNTRY,
       SUM(SCORE)   AS SUM_SCORE  ,
       COUNT(ID) AS TOTAL_NUMBER
FROM customers
GROUP BY country;


select country,
      avg(score) AS avg_score
from customers
where score !=0
group by country
having avg(score) > 430;


--unique list of all countries 

select distinct country
from customers


--top 3 customers with highest scores

select top 3 * 
from customers
order by score desc;


--two most recent orders
select top 2 * 
from orders
order by order_date desc;


--all we learn in single code
/*SELECT DISTINCT TOP 2
    COL1,
    SUM(COL2)
    FROM TABLE
    WHERE COL = 10
    GROUP BY COL1
    HAVING SUM(COL2)>30
    ORDER BY COL1 ASC;
*/
