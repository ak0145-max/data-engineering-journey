--need for recombine data,data enrichment,check for existence
--all data from customers and orders in two different result
SELECT *FROM customers
SELECT *FROM orders
--INNER JOIN - returns only matching rows from both tables
--find customers who placed an order

SELECT 
      c.id,
      c.first_name,
      o.order_id,
      o.sales
FROM orders AS o
INNER JOIN customers AS c
ON c.id = o.customer_id

--LEFT JOIN - returns all rows from left and only matching rows from right tables
--find customers who placed an order,include those without orders

SELECT 
      c.id,
      c.first_name,
      o.order_id,
      o.sales
FROM customers AS c
LEFT JOIN  orders AS o
ON c.id = o.customer_id


--RIGHT JOIN - returns all rows from RIGHT and only matching rows from LEFT tables
--find customers who placed an order,include orders withuot matching customers


SELECT 
      c.id,
      c.first_name,
      o.order_id,
      o.sales
FROM customers AS c
RIGHT JOIN  orders AS o
ON c.id = o.customer_id

--ALTERNATIVE OF RIGHT JOIN -- JUST Cng Table Position

SELECT 
      c.id,
      c.first_name,
      o.order_id,
      o.sales
FROM orders AS o 
LEFT JOIN customers AS c 
ON c.id = o.customer_id



--Full JOIN - return all rows from both table
--find all customers and all orders 

SELECT 
      c.id,
      c.first_name,
      o.order_id,
      o.sales
FROM orders AS o 
FULL JOIN customers AS c 
ON c.id = o.customer_id

--LEFT ANTI JOIN - returns row Left that has NO MATCH in Right
--get all customers who haven't placed any order



--RIGHT ANTI JOIN - returns row Right that has NO MATCH in Left
--get orders without customers

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id =o.customer_id
WHERE C.id IS NULL


--ALTERNATIVE OF RIGHT JOIN -- JUST Cng Table Position

SELECT *
FROM orders AS o  
LEFT JOIN customers AS c
ON c.id =o.customer_id
WHERE C.id IS NULL


--FULL ANTI JOIN - returns ONLY ROWS THAT DONT MATCH IN EITHER TABLES
--get CUSTOMERS WITHOUT ORDERS AND orders without customers 

SELECT *
FROM orders AS o  
FULL JOIN customers AS c
ON c.id =o.customer_id
WHERE C.id IS NULL OR O.customer_id IS NULL


--GET ALL CUSTOMERS ALONG WITH THEIR ORDERS BUT ONLY FOR CUSTOMERS WHO HAVE PLACED AND ORDER(WITHOUT INNER JOIN)

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id =o.customer_id
WHERE o.customer_id IS NOT NULL


--CROSS JOIN - COMBINES EVERY ROW FROM LEFT WITH EVRY ROW FROM RIGHT ALL POSSIBLE COMBINATIONS -CARTERSIAN JOIN
--get ALL POSSIBLE COMBINATION OF CUSTOMERS AND ORDERS

SELECT * 
FROM customers
CROSS JOIN orders