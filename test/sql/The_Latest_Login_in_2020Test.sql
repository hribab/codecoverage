-- Create a sample Logins table for testing
CREATE TABLE Logins
(
    user_id INT,
    time_stamp DATETIME,
    PRIMARY KEY (user_id, time_stamp)
);

-- Insert some sample data into the Logins table
INSERT INTO Logins (user_id, time_stamp) VALUES
(1, '2020-01-10 14:24:12'),
(1, '2020-12-25 18:15:30'),
(2, '2020-05-20 10:05:55'),
(2, '2019-11-15 16:30:45'),
(3, '2021-01-03 21:20:20'),
(4, '2020-02-14 09:10:25'),
(4, '2020-06-10 17:45:50');

-- Test case 1: user_id exists in Logins table and has logins in 2020
SELECT
    CASE 
        WHEN COUNT(1) = 1 AND last_stamp = '2020-12-25 18:15:30' THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result
FROM
(
    SELECT
        user_id,
        MAX(time_stamp) as last_stamp
    FROM
        Logins
    WHERE
        time_stamp > '2020-01-01 00:00:00'
        AND time_stamp < '2021-01-01 00:00:00'
    GROUP BY user_id
) tt
WHERE tt.user_id = 1;

-- Test case 2: user_id has logins in 2020 and not in the given date range
SELECT
    CASE 
        WHEN COUNT(1) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result
FROM
(
    SELECT
        user_id,
        MAX(time_stamp) as last_stamp
    FROM
        Logins
    WHERE
        time_stamp > '2020-06-15 00:00:00'
        AND time_stamp < '2020-12-01 00:00:00'
    GROUP BY user_id
) tt
WHERE tt.user_id = 2;

-- Test case 3: user_id has no logins in 2020
SELECT
    CASE 
        WHEN COUNT(1) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result
FROM
(
    SELECT
        user_id,
        MAX(time_stamp) as last_stamp
    FROM
        Logins
    WHERE
        time_stamp > '2020-01-01 00:00:00'
        AND time_stamp < '2021-01-01 00:00:00'
    GROUP BY user_id
) tt
WHERE tt.user_id = 3;

-- Test case 4: user_id has multiple logins in 2020
SELECT
    CASE 
        WHEN COUNT(1) = 1 AND last_stamp = '2020-06-10 17:45:50' THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result
FROM
(
    SELECT
        user_id,
        MAX(time_stamp) as last_stamp
    FROM
        Logins
    WHERE
        time_stamp > '2020-01-01 00:00:00'
        AND time_stamp < '2021-01-01 00:00:00'
    GROUP BY user_id
) tt
WHERE tt.user_id = 4;

-- Test case 5: Test for the correct total number of users with logins in 2020
SELECT
    CASE 
        WHEN COUNT(1) = 3 THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result
FROM
(
    SELECT
        user_id,
        MAX(time_stamp) as last_stamp
    FROM
        Logins
    WHERE
        time_stamp > '2020-01-01 00:00:00'
        AND time_stamp < '2021-01-01 00:00:00'
    GROUP BY user_id
) tt;