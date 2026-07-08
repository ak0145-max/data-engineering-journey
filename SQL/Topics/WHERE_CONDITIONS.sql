--country from germany
SELECT * 
FROM customers
WHERE country <> 'Germany'  --<> for not  equal

--score greater than 500 

SELECT * 
FROM customers
WHERE score <= 500  -- 500 or less

--USA AND >500
SELECT * 
FROM customers
WHERE country = 'USA' AND score > 500

--Either USA OR >500
SELECT * 
FROM customers
WHERE country = 'USA' OR score > 500


--A SCORE NOT LESS THAN 500
SELECT * 
FROM customers
WHERE NOT score < 500

--SCORE BETWEEN 100 TO 500
SELECT * 
FROM customers
WHERE score BETWEEN 100 AND 500


--EITHER GERMANY OR USA
SELECT *
FROM customers
WHERE country IN('Germany','USA')

--LIKE % MEAN ANYTHING _ MEAN EXACT
--whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

--ENDS WITH N
SELECT *
FROM customers
WHERE first_name LIKE '%n'

--just contains 'r'
SELECT *
FROM customers
--WHERE first_name LIKE '%r%'
WHERE first_name LIKE '__r%'
