--Create a new table

CREATE TABLE persons(
    id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY(id)
)

--add new col
ALTER TABLE persons
ADD phone VARCHAR(15) NOT NULL

--REMOVE COL
ALTER TABLE persons
DROP COLUMN email


SELECT * FROM persons;


--delete table
DROP TABLE persons