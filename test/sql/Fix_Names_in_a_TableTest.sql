-- Create a test table and insert sample records
CREATE TABLE test_users (
  user_id INT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO test_users (user_id, name) VALUES
(1, 'ADAM'),
(2, 'disiLLa'),
(3, 'TOny'),
(4, 'ALFRED'),
(5, 'miLLIe');


-- Test Case 1: Check if the first character is uppercase and rest are lowercase
SELECT CASE
  WHEN name = 'Adam' THEN 'PASS'
  ELSE 'FAIL'
END AS test_result
FROM (
  SELECT user_id, CONCAT(UPPER(substring(name,1,1)), LOWER(substring(name, 2))) AS name FROM test_users WHERE user_id = 1
) result;

-- Test Case 2: Check if the name with mixed case characters gets fixed properly
SELECT CASE
  WHEN name = 'Disilla' THEN 'PASS'
  ELSE 'FAIL'
END AS test_result
FROM (
  SELECT user_id, CONCAT(UPPER(substring(name,1,1)), LOWER(substring(name, 2))) AS name FROM test_users WHERE user_id = 2
) result;

-- Test Case 3: Check if the already correct name remains unchanged
SELECT CASE
  WHEN name = 'Tony' THEN 'PASS'
  ELSE 'FAIL'
END AS test_result
FROM (
  SELECT user_id, CONCAT(UPPER(substring(name,1,1)), LOWER(substring(name, 2))) AS name FROM test_users WHERE user_id = 3
) result;

-- Test Case 4: Check if the name with all capital letters gets fixed properly
SELECT CASE
  WHEN name = 'Alfred' THEN 'PASS'
  ELSE 'FAIL'
END AS test_result
FROM (
  SELECT user_id, CONCAT(UPPER(substring(name,1,1)), LOWER(substring(name, 2))) AS name FROM test_users WHERE user_id = 4
) result;

-- Test Case 5: Check if the name with first capital and remaining small letters gets fixed properly
SELECT CASE
  WHEN name = 'Millie' THEN 'PASS'
  ELSE 'FAIL'
END AS test_result
FROM (
  SELECT user_id, CONCAT(UPPER(substring(name,1,1)), LOWER(substring(name, 2))) AS name FROM test_users WHERE user_id = 5
) result;