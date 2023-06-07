-- Create test data for Employee table
CREATE TABLE Employee (
  id int PRIMARY KEY,
  salary int
);

-- Insert test data into Employee table
INSERT INTO Employee VALUES (1, 3000), (2, 2500), (3, 4000), (4, 6000), (5, 5600);

-- Test case 1: Basic test case - Return second highest salary in the table
-- Expected result: secondHighestSalary = 5600
SELECT max(salary) as secondHighestSalary FROM Employee
WHERE salary NOT IN (SELECT max(salary) FROM Employee);

-- Test case 2: Table has only one row
-- Expected result: secondHighestSalary = NULL
DELETE FROM Employee WHERE id != 1;
SELECT max(salary) as secondHighestSalary FROM Employee
WHERE salary NOT IN (SELECT max(salary) FROM Employee);

-- Test case 3: Table has multiple rows with the same highest salary
-- Expected result: secondHighestSalary = 4000
INSERT INTO Employee VALUES (6, 6000);
SELECT max(salary) as secondHighestSalary FROM Employee
WHERE salary NOT IN (SELECT max(salary) FROM Employee);

-- Test case 4: Table has multiple rows with the same second-highest salary
-- Expected result: secondHighestSalary = 4000
INSERT INTO Employee VALUES (7, 4000);
SELECT max(salary) as secondHighestSalary FROM Employee
WHERE salary NOT IN (SELECT max(salary) FROM Employee);

-- Test case 5: Table consists of the same salary values for all rows
-- Expected result: secondHighestSalary = NULL
DELETE FROM Employee WHERE id not in (1, 6);
INSERT INTO Employee VALUES (8, 6000), (9, 6000), (10, 6000);
SELECT max(salary) as secondHighestSalary FROM Employee
WHERE salary NOT IN (SELECT max(salary) FROM Employee);

-- Clean up the test data
DROP TABLE Employee;