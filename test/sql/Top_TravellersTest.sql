-- Create sample tables for testing
CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE Rides (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT
);

-- Insert sample data for testing
INSERT INTO Users(id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

INSERT INTO Rides(id, user_id, distance) VALUES
(1, 1, 120),
(2, 2, 100),
(3, 3, 200),
(4, 4, 140),
(5, 3, 50),
(6, 1, 400),
(7, 2, 150),
(8, 1, 314);

-- Test case 1: Verify that users with no rides have a distance of 0
-- Expected output: David, 0
SELECT * FROM (
    SELECT name, COALESCE(travelled_distance,0) AS travelled_distance FROM Users LEFT JOIN
    (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS total_distance ON Users.id = total_distance.user_id
) as test WHERE name='David';

-- Test case 2: Verify that users with multiple rides have the correct total distance
-- Expected output: Alice, 834
SELECT * FROM (
    SELECT name, COALESCE(travelled_distance,0) AS travelled_distance FROM Users LEFT JOIN
    (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS total_distance ON Users.id = total_distance.user_id
) as test WHERE name='Alice';

-- Test case 3: Verify that users are ordered by traveled distance in descending order
-- Expected output: Alice, 834
SELECT * FROM (
    SELECT name, COALESCE(travelled_distance,0) AS travelled_distance FROM Users LEFT JOIN
    (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS total_distance ON Users.id = total_distance.user_id
    ORDER BY travelled_distance DESC, name ASC
) as test LIMIT 1;

-- Test case 4: Verify that users with the same traveled distance are ordered by name in ascending order
-- Expected output: Bob, 250
SELECT * FROM (
    SELECT name, COALESCE(travelled_distance,0) AS travelled_distance FROM Users LEFT JOIN
    (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS total_distance ON Users.id = total_distance.user_id
    ORDER BY travelled_distance DESC, name ASC
) as test WHERE travelled_distance=250 LIMIT 1;

-- Test case 5: Verify that the correct number of users is returned
-- Expected output: 4
SELECT COUNT(*) FROM (
    SELECT name, COALESCE(travelled_distance,0) AS travelled_distance FROM Users LEFT JOIN
    (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS total_distance ON Users.id = total_distance.user_id
) as test;

-- Drop sample tables after testing
DROP TABLE Users;
DROP TABLE Rides;