Create TABLE Books(
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    price DECIMAL(8,2) CHECK (price > 0)
  );

  CREATE TABLE Members(
     member_id INT PRIMARY KEY,
     name VARCHAR(100),
     email VARCHAR(100) UNIQUE,
     join_date DATE
  );

  INSERT INTO BOOKS VALUES(1,'DBMS','R. Elmasri',650);
  INSERT INTO BOOKS VALUES(2,'OP','A. Silberschatz',550);
  INSERT INTO BOOKS VALUES(3,'SD','S. Sudo',750); 

  INSERT INTO Members VALUES(1,'R. Elmasri','emarsi@gmail.com', '2026-01-01');
  INSERT INTO Members VALUES(2,'A. Silberschatz','silber@gmail.com', '2026-01-15');
  INSERT INTO Members VALUES(3,'S. Sudo','sudo@gmail.com', '2026-01-17');


  SELECT *
  FROM Books;

  
  SELECT *
  FROM Members;


  CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  credit_hours INT CHECK (credit_hours > 0)
);

CREATE TABLE Registration (
  reg_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  reg_date DATE DEFAULT GETDATE(),
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

 
 INSERT INTO Students VALUES (1, 'Ahmed Khan', 'ahmed@gmail.com');
INSERT INTO Students VALUES (2, 'Sara Ali', 'sara@gmail.com');
INSERT INTO Students VALUES (3, 'Rahim Uddin', 'rahim@gmail.com');


INSERT INTO Courses VALUES (101, 'Database Management Systems', 3);
INSERT INTO Courses VALUES (102, 'Operating Systems', 4);
INSERT INTO Courses VALUES (103, 'Artificial Intelligence', 5);
INSERT INTO Courses VALUES (104, 'Computer Networks', 4);
INSERT INTO Courses VALUES (105, 'Software Engineering', 5);
INSERT INTO Courses VALUES (106, 'Web Development', 3);
INSERT INTO Courses VALUES (107, 'Data Science', 4);


INSERT INTO Registration (reg_id, student_id, course_id)
VALUES (1, 1, 101);

INSERT INTO Registration (reg_id, student_id, course_id)
VALUES (2, 1, 102);

INSERT INTO Registration (reg_id, student_id, course_id)
VALUES (3, 2, 103);

SELECT * FROM Courses;





 CREATE VIEW HighCreditCourses AS
 SELECT *
 FROM Courses
 WHERE credit_hours > 3;

 SELECT * FROM HighCreditCourses;

 CREATE User test_user IDENTIFIED ---BY test123;--Oracle style
 GRANT CONNECT TO test_user;
 REVOKE INSERT ON Books FROM test_user;




 SET SERVEROUTPUT ON
 DECLARE
       score1 NUMBER := 75;
       score2 NUMBER := 88;
       score3 NUMBER := 82;
       max_score NUMBER;
BEGIN
   IF score1 >= score2 And score1 >= score3 THEN
      max_score := score1;
   ELSIF score2 >= score1 AND score2 >= score3 THEN
    max_score := score2;
  ELSE
    max_score := score3;
  END IF;

   DBMS_OUTPUT.PUT_LINE('Highest Score is: '  || max_score);
END;
    


    DECLARE
  CURSOR book_cur IS
    SELECT title FROM Books WHERE price > 500;
  v_title Books.title%TYPE;
BEGIN
  OPEN book_cur;
  LOOP
    FETCH book_cur INTO v_title;
    EXIT WHEN book_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Book Title: ' || v_title);
  END LOOP;
  CLOSE book_cur;
END;


Select*from
Students;
select * from 
Courses;
select * from
Registration;
select * from 
Books;


SELECT name, cgpa
FROM Students
WHERE cgpa > (SELECT AVG(cgpa) FROM Students);