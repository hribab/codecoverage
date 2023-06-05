-- Test case 1: Check default table values
-- Insert sample data to Person table
INSERT INTO Person (id, email)
VALUES (1, 'test1@test.com'), (2, 'test2@test.com'), (3, 'test1@test.com'), (4, 'test3@test.com'), (5, 'test4@test.com'), (6, 'test4@test.com');

-- Execute the main code to check for duplicate emails
SELECT email as Email
FROM (SELECT COUNT(email) as count_email, email
    FROM Person
    GROUP BY email) AS emailc
WHERE count_email > 1;

-- Expected result: test1@test.com, test4@test.com

-- Test case 2: Check empty table
-- Truncate the Person table
TRUNCATE TABLE Person;

-- Execute the main code to check for duplicate emails
SELECT email as Email
FROM (SELECT COUNT(email) as count_email, email
    FROM Person
    GROUP BY email) AS emailc
WHERE count_email > 1;

-- Expected result: no rows

-- Test case 3: Check no duplicate emails
-- Insert sample data to Person table
INSERT INTO Person (id, email)
VALUES (1, 'test1@test.com'), (2, 'test2@test.com'), (3, 'test3@test.com'), (4, 'test4@test.com'), (5, 'test5@test.com'), (6, 'test6@test.com');

-- Execute the main code to check for duplicate emails
SELECT email as Email
FROM (SELECT COUNT(email) as count_email, email
    FROM Person
    GROUP BY email) AS emailc
WHERE count_email > 1;

-- Expected result: no rows

-- Test case 4: Check all duplicate emails
-- Truncate the Person table
TRUNCATE TABLE Person;

-- Insert sample data to Person table
INSERT INTO Person (id, email)
VALUES (1, 'test1@test.com'), (2, 'test1@test.com'), (3, 'test1@test.com'), (4, 'test1@test.com'), (5, 'test1@test.com'), (6, 'test1@test.com');

-- Execute the main code to check for duplicate emails
SELECT email as Email
FROM (SELECT COUNT(email) as count_email, email
    FROM Person
    GROUP BY email) AS emailc
WHERE count_email > 1;

-- Expected result: test1@test.com

-- Test case 5: Check multiple duplicate emails with different frequency
-- Truncate the Person table
TRUNCATE TABLE Person;

-- Insert sample data to Person table
INSERT INTO Person (id, email)
VALUES (1, 'test1@test.com'), (2, 'test2@test.com'), (3, 'test1@test.com'), (4, 'test3@test.com'), (5, 'test4@test.com'), (6, 'test4@test.com'), (7, 'test1@test.com'), (8, 'test3@test.com'), (9, 'test3@test.com');

-- Execute the main code to check for duplicate emails
SELECT email as Email
FROM (SELECT COUNT(email) as count_email, email
    FROM Person
    GROUP BY email) AS emailc
WHERE count_email > 1;

-- Expected result: test1@test.com, test3@test.com, test4@test.com