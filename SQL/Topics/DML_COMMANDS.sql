--inserting value

INSERT INTO customers(id ,first_name,country,score)
VALUES(6,'Alex','BAN',NULL),
      (7,'Korain',Null,100)


--inset data from customers into persons
INSERT INTO persons(id,person_name,birth_date,phone)
SELECT 
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers;

SELECT * FROM persons;


--change the score of customer 6 to 0
UPDATE customers
SET score = 0
WHERE  id = 6

UPDATE customers
SET score = 0,
    country = 'UK'
WHERE  id = 4



SELECT * FROM customers
WHERE id = 6


SELECT * FROM customers
WHERE id = 4


--delete ID GREATER THAN 5
DELETE FROM customers
WHERE id >5

--delete all data from persons

DELETE FROM persons

TRUNCATE TABLE persons
