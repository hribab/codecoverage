-- Create test data
CREATE TABLE test_Salary
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    sex CHAR(1),
    salary INT
);

-- Insert test data
INSERT INTO test_Salary VALUES (1, 'Alice', 'f', 5000);
INSERT INTO test_Salary VALUES (2, 'Bob', 'm', 6000);
INSERT INTO test_Salary VALUES (3, 'Carol', 'f', 7000);
INSERT INTO test_Salary VALUES (4, 'Dave', 'm', 8000);
INSERT INTO test_Salary VALUES (5, 'Eva', 'f', 9000);

-- Execute the Swap Salary code
UPDATE test_Salary
SET sex = IF(sex='f','m','f');

-- Test case 1: Verify that there are no sex values equal to 'f' after swapping
SELECT COUNT(*) 
FROM test_Salary
WHERE sex = 'f';

-- Test case 2: Verify that there are no sex values equal to 'm' after swapping
SELECT COUNT(*) 
FROM test_Salary
WHERE sex = 'm';

-- Test case 3: Verify that the number of sex values swapped from 'f' to 'm' is correct
SELECT COUNT(*) 
FROM test_Salary
WHERE sex = 'm' AND id IN (1, 3, 5);

-- Test case 4: Verify that the number of sex values swapped from 'm' to 'f' is correct
SELECT COUNT(*) 
FROM test_Salary
WHERE sex = 'f' AND id IN (2, 4);

-- Test case 5: Verify that the salary values remain unchanged after swapping
SELECT * 
FROM test_Salary
ORDER BY id;

-- Clean up test data
DROP TABLE test_Salary;
