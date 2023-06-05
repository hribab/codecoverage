-- Create test data
CREATE TABLE TEST_WEATHER (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);

-- Test case 1: Basic test case with consecutive days and increasing temperature 
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (1, '2022-01-01', 10);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (2, '2022-01-02', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (3, '2022-01-03', 14);
-- Expect: 2, 3

-- Test case 2: Basic test case with consecutive days and non-increasing temperature
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (4, '2022-01-04', 14);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (5, '2022-01-05', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (6, '2022-01-06', 10);
-- Expect: empty result

-- Test case 3: Test case with non-consecutive days and increasing temperature
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (7, '2022-01-08', 10);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (8, '2022-01-09', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (9, '2022-01-11', 14);
-- Expect: 8

-- Test case 4: Test case with non-consecutive days and non-increasing temperature
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (10, '2022-01-12', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (11, '2022-01-14', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (12, '2022-01-16', 10);
-- Expect: empty result

-- Test case 5: Test case with a mix of different dates and temperatures
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (13, '2022-01-17', 10);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (14, '2022-01-18', 12);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (15, '2022-01-20', 14);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (16, '2022-01-21', 14);
INSERT INTO TEST_WEATHER (id, recordDate, temperature) VALUES (17, '2022-01-23', 12);
-- Expect: 14

-- Execute test query
SELECT W1.id FROM TEST_WEATHER W1, TEST_WEATHER W2
WHERE DATEDIFF(W1.recordDate, W2.recordDate) = 1 AND W1.temperature > W2.temperature;

-- Cleanup
DROP TABLE TEST_WEATHER;
