-- Test Case 1: Test with an empty table.
/*
This test case is to check if the code works for an empty table.
Expected output: empty table.
*/

INSERT INTO Employees (employee_id, name, salary) VALUES (); -- inserting nothing
SELECT * FROM Employees; -- displaying inserted data
SELECT employee_id, IF(employee_id %2 <> 0 AND name NOT LIKE 'M%', salary, 0) as bonus FROM Employees ORDER BY employee_id; -- executing main code

-- Test Case 2: Test with employees having even ID and name starting with 'M'.
/*
This test case is to check if the code works for employees who have even employee_id and name starts with 'M'.
Expected output: All employees should have bonus = 0.
*/

INSERT INTO Employees (employee_id, name, salary)
VALUES (2, 'Michael', 1000), (4, 'Mary', 2000), (6, 'Maria', 3000); -- inserting sample data
SELECT * FROM Employees; -- displaying inserted data
SELECT employee_id, IF(employee_id %2 <> 0 AND name NOT LIKE 'M%', salary, 0) as bonus FROM Employees ORDER BY employee_id; -- executing main code

-- Test Case 3: Test with employees having odd ID and name not starting with 'M'.
/*
This test case is to check if the code works for employees who have odd employee_id and name that does not start with 'M'.
Expected output: All employees should have bonus = 100% of their salary.
*/

DELETE from Employees; -- cleaning up previous data
INSERT INTO Employees (employee_id, name, salary)
VALUES (1, 'John', 1500), (3, 'Alice', 2500), (5, 'Oliver', 3500); -- inserting sample data
SELECT * FROM Employees; -- displaying inserted data
SELECT employee_id, IF(employee_id %2 <> 0 AND name NOT LIKE 'M%', salary, 0) as bonus FROM Employees ORDER BY employee_id; -- executing main code

-- Test Case 4: Test with mixed employees (even and odd IDs, names with and without 'M').
/*
This test case is to check if the code works for a mix of employees.
Expected output: Employees with odd IDs and names not starting with 'M' should have a bonus equal to their salary.
*/

DELETE from Employees; -- cleaning up previous data
INSERT INTO Employees (employee_id, name, salary)
VALUES
(1, 'John', 1500),
(2, 'Michael', 1000),
(3, 'Alice', 2500),
(4, 'Mary', 2000),
(5, 'Oliver', 3500),
(6, 'Maria', 3000); -- inserting sample data

SELECT * FROM Employees; -- displaying inserted data
SELECT employee_id, IF(employee_id %2 <> 0 AND name NOT LIKE 'M%', salary, 0) as bonus FROM Employees ORDER BY employee_id; -- executing main code

-- Test Case 5: Test with all employees having the same name and salary.
/*
This test case is to check if the code works for employees with the same name and salary.
Expected output: Employees with odd IDs should have a bonus equal to their salary.
*/

DELETE from Employees; -- cleaning up previous data
INSERT INTO Employees (employee_id, name, salary)
VALUES (1, 'John', 2000), (2, 'John', 2000), (3, 'John', 2000), (4, 'John', 2000), (5, 'John', 2000), (6, 'John', 2000); -- inserting sample data
SELECT * FROM Employees; -- displaying inserted data
SELECT employee_id, IF(employee_id %2 <> 0 AND name NOT LIKE 'M%', salary, 0) as bonus FROM Employees ORDER BY employee_id; -- executing main code