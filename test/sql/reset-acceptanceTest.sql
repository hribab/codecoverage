-- Test Case 1: Test creating the database
-- Prepare
DROP DATABASE IF EXISTS acceptance_test1;
-- Execute
CREATE DATABASE IF NOT EXISTS acceptance_test1;
-- Verify
SHOW DATABASES LIKE 'acceptance_test1';

-- Test Case 2: Test dropping the database
-- Prepare
CREATE DATABASE IF NOT EXISTS acceptance_test2;
-- Execute
DROP DATABASE IF EXISTS acceptance_test2;
-- Verify
SHOW DATABASES LIKE 'acceptance_test2';

-- Test Case 3: Test creating the user
-- Prepare
DROP USER IF EXISTS acceptance_test3@'%';
-- Execute
CREATE USER IF NOT EXISTS acceptance_test3@'%' IDENTIFIED BY 'acceptance';
-- Verify
SELECT User, Host FROM mysql.user WHERE User = 'acceptance_test3' AND Host = '%';

-- Test Case 4: Test dropping the user
-- Prepare
CREATE USER IF NOT EXISTS acceptance_test4@'%' IDENTIFIED BY 'acceptance';
-- Execute
DROP USER IF EXISTS acceptance_test4@'%';
-- Verify
SELECT User, Host FROM mysql.user WHERE User = 'acceptance_test4' AND Host = '%';

-- Test Case 5: Test granting privileges to the user
-- Prepare
DROP DATABASE IF EXISTS acceptance_test5;
CREATE DATABASE IF NOT EXISTS acceptance_test5;
CREATE USER IF NOT EXISTS acceptance_test5@'%' IDENTIFIED BY 'acceptance';
-- Execute
GRANT ALL PRIVILEGES ON acceptance_test5.* TO acceptance_test5@'%';
-- Verify
SHOW GRANTS FOR 'acceptance_test5'@'%';

-- Test Case 6: Test flushing privileges
-- Execute
FLUSH PRIVILEGES+ -- Independent command, no need for preparation or verification
