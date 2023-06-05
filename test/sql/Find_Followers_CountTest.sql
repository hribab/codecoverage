-- Test case 1: Check for empty table
--Expected output: Empty result as there are no users to count followers
INSERT INTO Followers(user_id, follower_id) VALUES (NULL, NULL);
SELECT * FROM Followers;

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id;

-- Cleanup test case data
DELETE FROM Followers WHERE user_id IS NULL AND follower_id IS NULL;

-- Test case 2: Check with 1 user and 1 follower
--Expected output: user_id = 1, followers_count = 1
INSERT INTO Followers(user_id, follower_id) VALUES (1, 1);
SELECT * FROM Followers;

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id;

-- Cleanup test case data
DELETE FROM Followers WHERE user_id = 1 AND follower_id = 1;

-- Test case 3: Check with multiple users having followers
--Expected output: user_id = 1, followers_count = 2
--                 user_id = 2, followers_count = 1
INSERT INTO Followers(user_id, follower_id) VALUES (1, 1);
INSERT INTO Followers(user_id, follower_id) VALUES (1, 2);
INSERT INTO Followers(user_id, follower_id) VALUES (2, 3);
SELECT * FROM Followers;

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id;

-- Cleanup test case data
DELETE FROM Followers WHERE (user_id = 1 AND follower_id = 1) OR (user_id = 1 AND follower_id = 2) OR (user_id = 2 AND follower_id = 3);

-- Test case 4: Check with users who have no followers 
--Expected output: user_id = 1, followers_count = 1
--                 user_id = 2, followers_count = 0
--                 user_id = 3, followers_count = 0
INSERT INTO Followers(user_id, follower_id) VALUES (1, 1);
SELECT * FROM Followers;

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM (SELECT user_id FROM Followers UNION SELECT follower_id FROM Followers) AS all_users 
LEFT JOIN Followers on all_users.user_id = Followers.user_id
GROUP BY all_users.user_id 
ORDER BY all_users.user_id;

-- Cleanup test case data
DELETE FROM Followers WHERE user_id = 1 AND follower_id = 1;

-- Test case 5: Check with follower_id is NULL
--Expected output: user_id = 1, followers_count = 0
--                 user_id = 2, followers_count = 1
--                 user_id = 3, followers_count = 1
INSERT INTO Followers(user_id, follower_id) VALUES (1, NULL);
INSERT INTO Followers(user_id, follower_id) VALUES (2, 1);
INSERT INTO Followers(user_id, follower_id) VALUES (3, 1);
SELECT * FROM Followers;

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id;