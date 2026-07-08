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
