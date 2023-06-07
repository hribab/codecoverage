CREATE TABLE calls (
  from_id INT,
  to_id INT,
  duration INT
);

INSERT INTO calls (from_id, to_id, duration) VALUES (1, 2, 59);
INSERT INTO calls (from_id, to_id, duration) VALUES (2, 1, 11);
INSERT INTO calls (from_id, to_id, duration) VALUES (1, 3, 20);
INSERT INTO calls (from_id, to_id, duration) VALUES (3, 4, 100);
INSERT INTO calls (from_id, to_id, duration) VALUES (3, 4, 200);
INSERT INTO calls (from_id, to_id, duration) VALUES (3, 4, 200);
INSERT INTO calls (from_id, to_id, duration) VALUES (4, 3, 499);

-- Test1: Standard test case
-- Test data setup done with base script
-- Expected output:
-- 1 | 2 | 2 | 70
-- 1 | 3 | 1 | 20
-- 3 | 4 | 4 | 999

-- Test2: No calls
-- Test data
TRUNCATE TABLE calls;
-- Expected output: {}

-- Test3: Single call
-- Test data
INSERT INTO calls (from_id, to_id, duration) VALUES (2, 3, 30);
-- Expected output:
-- 2 | 3 | 1 | 30

-- Test4: Repeated calls between two persons
-- Test data
DELETE FROM calls WHERE from_id IN (2, 4);
INSERT INTO calls (from_id, to_id, duration) VALUES (1, 3, 15);
INSERT INTO calls (from_id, to_id, duration) VALUES (3, 1, 20);
INSERT INTO calls (from_id, to_id, duration) VALUES (1, 3, 30);
-- Expected output:
-- 1 | 3 | 3 | 65

-- Test5: Calls between multiple persons
-- Test data
INSERT INTO calls (from_id, to_id, duration) VALUES (2, 4, 10);
INSERT INTO calls (from_id, to_id, duration) VALUES (1, 4, 40);
INSERT INTO calls (from_id, to_id, duration) VALUES (2, 3, 50);
INSERT INTO calls (from_id, to_id, duration) VALUES (3, 4, 60);
-- Expected output:
-- 1 | 3 | 3 | 65
-- 1 | 4 | 1 | 40
-- 2 | 3 | 2 | 80
-- 2 | 4 | 1 | 10