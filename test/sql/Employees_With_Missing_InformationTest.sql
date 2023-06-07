-- Create test tables and insert test data
CREATE TABLE Employees_test (
  employee_id int PRIMARY KEY,
  name varchar
);

CREATE TABLE Salaries_test (
  employee_id int PRIMARY KEY,
  salary int
);

INSERT INTO Employees_test VALUES (1, 'John');
INSERT INTO Employees_test VALUES (2, 'Jane');
INSERT INTO Employees_test VALUES (3, 'Joe');
INSERT INTO Employees_test VALUES (4, NULL);
INSERT INTO Employees_test VALUES (5, 'Jill');

INSERT INTO Salaries_test VALUES (1, 50000);
INSERT INTO Salaries_test VALUES (3, 60000);
INSERT INTO Salaries_test VALUES (4, 40000);
INSERT INTO Salaries_test VALUES (5, NULL);
INSERT INTO Salaries_test VALUES (6, 45000);

-- Test case 1: Employees with missing names and missing salaries
SELECT employee_id
FROM Employees_test
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries_test)
    UNION
SELECT employee_id
FROM Salaries_test
WHERE employee_id NOT IN (SELECT employee_id FROM Employees_test)
ORDER BY employee_id;

-- Test case 2: No missing information
DELETE FROM Employees_test WHERE employee_id = 4;
DELETE FROM Salaries_test WHERE employee_id = 5 OR employee_id = 6;

SELECT employee_id
FROM Employees_test
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries_test)
    UNION
SELECT employee_id
FROM Salaries_test
WHERE employee_id NOT IN (SELECT employee_id FROM Employees_test)
ORDER BY employee_id;

-- Test case 3: All employees with missing names and missing salaries
TRUNCATE TABLE Employees_test;
TRUNCATE TABLE Salaries_test;

INSERT INTO Employees_test VALUES (1, NULL);
INSERT INTO Employees_test VALUES (2, NULL);
INSERT INTO Employees_test VALUES (3, NULL);

INSERT INTO Salaries_test VALUES (4, 50000);
INSERT INTO Salaries_test VALUES (5, 60000);
INSERT INTO Salaries_test VALUES (6, 40000);

SELECT employee_id
FROM Employees_test
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries_test)
    UNION
SELECT employee_id
FROM Salaries_test
WHERE employee_id NOT IN (SELECT employee_id FROM Employees_test)
ORDER BY employee_id;

-- Test case 4: Only one employee with missing information
TRUNCATE TABLE Employees_test;
TRUNCATE TABLE Salaries_test;

INSERT INTO Employees_test VALUES (1, 'John');
INSERT INTO Employees_test VALUES (2, 'Jane');
INSERT INTO Employees_test VALUES (3, NULL);

INSERT INTO Salaries_test VALUES (1, 50000);
INSERT INTO Salaries_test VALUES (2, 60000);
INSERT INTO Salaries_test VALUES (4, 40000);

SELECT employee_id
FROM Employees_test
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries_test)
    UNION
SELECT employee_id
FROM Salaries_test
WHERE employee_id NOT IN (SELECT employee_id FROM Employees_test)
ORDER BY employee_id;

-- Test case 5: Case sensitivity check
TRUNCATE TABLE Employees_test;
TRUNCATE TABLE Salaries_test;

INSERT INTO Employees_test VALUES (1, 'John');
INSERT INTO Employees_test VALUES (2, 'Jane');
INSERT INTO Employees_test VALUES (3, 'joe');

INSERT INTO Salaries_test VALUES (1, 50000);
INSERT INTO Salaries_test VALUES (2, 60000);
INSERT INTO Salaries_test VALUES (4, 40000);

SELECT employee_id
FROM Employees_test
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries_test)
    UNION
SELECT employee_id
FROM Salaries_test
WHERE employee_id NOT IN (SELECT employee_id FROM Employees_test)
ORDER BY employee_id;

-- Drop test tables after testing
DROP TABLE Employees_test;
DROP TABLE Salaries_test;