-- Test 1: No duplicates in the table, nothing should be deleted
-- Prepare test data
INSERT INTO person (id, email) VALUES (1, 'test1@example.com');
INSERT INTO person (id, email) VALUES (2, 'test2@example.com');
INSERT INTO person (id, email) VALUES (3, 'test3@example.com');

-- Run the query
DELETE p1
FROM person p1, person p2
WHERE p1.email = p2.email and p1.id > p2.id;

-- Test 2: Multiple duplicates, only keep the one with the minimum id
-- Prepare test data
DELETE FROM person;
INSERT INTO person (id, email) VALUES (1, 'test@example.com');
INSERT INTO person (id, email) VALUES (2, 'test@example.com');
INSERT INTO person (id, email) VALUES (3, 'test@example.com');

-- Run the query
DELETE p1
FROM person p1, person p2
WHERE p1.email = p2.email and p1.id > p2.id;

-- Test 3: Mix of unique and duplicate emails
-- Prepare test data
DELETE FROM person;
INSERT INTO person (id, email) VALUES (1, 'test1@example.com');
INSERT INTO person (id, email) VALUES (2, 'test2@example.com');
INSERT INTO person (id, email) VALUES (3, 'test2@example.com');
INSERT INTO person (id, email) VALUES (4, 'test3@example.com');
INSERT INTO person (id, email) VALUES (5, 'test3@example.com');

-- Run the query
DELETE p1
FROM person p1, person p2
WHERE p1.email = p2.email and p1.id > p2.id;

-- Test 4: All emails are duplicates with different id values
-- Prepare test data
DELETE FROM person;
INSERT INTO person (id, email) VALUES (1, 'test@example.com');
INSERT INTO person (id, email) VALUES (2, 'test@example.com');
INSERT INTO person (id, email) VALUES (3, 'test@example.com');
INSERT INTO person (id, email) VALUES (4, 'test@example.com');
INSERT INTO person (id, email) VALUES (5, 'test@example.com');

-- Run the query
DELETE p1
FROM person p1, person p2
WHERE p1.email = p2.email and p1.id > p2.id;

-- Test 5: Empty table, nothing should be deleted
-- Prepare test data
DELETE FROM person;

-- Run the query
DELETE p1
FROM person p1, person p2
WHERE p1.email = p2.email and p1.id > p2.id;