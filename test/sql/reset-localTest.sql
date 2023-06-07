-- Test Case 1: Test if database 'local' is dropped when it exists
-- Create a dummy database to be dropped
CREATE DATABASE IF NOT EXISTS `dummy_local`;
DROP DATABASE IF EXISTS `local`;

-- Execute the function
CALL reset_local();

-- Check if database is dropped successfully
SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'local';

-- Test Case 2: Test if database 'local' is created when it doesn't exist
-- Drop the 'local' database if it exists
DROP DATABASE IF EXISTS `local`;

-- Execute the function
CALL reset_local();

-- Check if database is created successfully
SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'local';

-- Test Case 3: Test if the user 'local'@'%' is created when it doesn't exist
-- Drop the 'local'@'%' user if exists
DROP USER IF EXISTS 'local'@'%';

-- Execute the function
CALL reset_local();

-- Check if user is created successfully
SELECT user, host FROM mysql.user WHERE user='local' AND host='%';

-- Test Case 4: Test if the user 'local'@'%' has all privileges on `local`.*
-- Drop the user if it exists and recreate without any privileges
DROP USER IF EXISTS 'local'@'%';
CREATE USER IF NOT EXISTS 'local'@'%' IDENTIFIED BY 'local';

-- Execute the function
CALL reset_local();

-- Check if the user has all privileges on 'local'.*
SHOW GRANTS FOR 'local'@'%';

-- Test Case 5: Test if FLUSH PRIVILEGES is executed
-- Create a user without any privileges
DROP USER IF EXISTS 'test_user'@'%';
CREATE USER 'test_user'@'%' IDENTIFIED BY 'password';

-- Grant the user SELECT privilege on local
GRANT SELECT ON local.* TO 'test_user'@'%';

-- Execute the function
CALL reset_local();

-- The user should have only the SELECT privilege
SHOW GRANTS FOR 'test_user'@'%';