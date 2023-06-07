-- Test case 1: Basic example from prompt

-- Create test table
CREATE TABLE Queries_test1 (
    query_name varchar(255),
    result varchar(255),
    position int,
    rating int
);

-- Insert values into test table
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 5);
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', 2, 5);
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Dog', 'Mule', 200, 1);
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Cat', 'Shirazi', 5, 2);
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Cat', 'Siamese', 3, 3);
INSERT INTO Queries_test1 (query_name, result, position, rating) VALUES ('Cat', 'Sphynx', 7, 4);

-- Execute query using test table
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(query_name), 2) AS quality,
    ROUND(((SUM(rating < 3))/COUNT(query_name)) * 100, 2) AS poor_query_percentage
FROM
    Queries_test1
GROUP BY
    query_name;

-- Test case 2: All ratings less than 3

-- Create test table
CREATE TABLE Queries_test2 (
    query_name varchar(255),
    result varchar(255),
    position int,
    rating int
);

-- Insert values into test table
INSERT INTO Queries_test2 (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 2);
INSERT INTO Queries_test2 (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', 2, 1);

-- Execute query using test table
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(query_name), 2) AS quality,
    ROUND(((SUM(rating < 3))/COUNT(query_name)) * 100, 2) AS poor_query_percentage
FROM
    Queries_test2
GROUP BY
    query_name;

-- Test case 3: Only one query type

-- Create test table
CREATE TABLE Queries_test3 (
    query_name varchar(255),
    result varchar(255),
    position int,
    rating int
);

-- Insert values into test table
INSERT INTO Queries_test3 (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 5);

-- Execute query using test table
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(query_name), 2) AS quality,
    ROUND(((SUM(rating < 3))/COUNT(query_name)) * 100, 2) AS poor_query_percentage
FROM
    Queries_test3
GROUP BY
    query_name;

-- Test case 4: Ratings equal to 3 (no poor query)

-- Create test table
CREATE TABLE Queries_test4 (
    query_name varchar(255),
    result varchar(255),
    position int,
    rating int
);

-- Insert values into test table
INSERT INTO Queries_test4 (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 3);

-- Execute query using test table
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(query_name), 2) AS quality,
    ROUND(((SUM(rating < 3))/COUNT(query_name)) * 100, 2) AS poor_query_percentage
FROM
    Queries_test4
GROUP BY
    query_name;

-- Test case 5: Multiple query types

-- Create test table
CREATE TABLE Queries_test5 (
    query_name varchar(255),
    result varchar(255),
    position int,
    rating int
);

-- Insert values into test table
INSERT INTO Queries_test5 (query_name, result, position, rating) VALUES ('Dog', 'Golden Retriever', 1, 5);
INSERT INTO Queries_test5 (query_name, result, position, rating) VALUES ('Dog', 'German Shepherd', 2, 5);
INSERT INTO Queries_test5 (query_name, result, position, rating) VALUES ('Cat', 'Shirazi', 5, 2);
INSERT INTO Queries_test5 (query_name, result, position, rating) VALUES ('Fish', 'Goldfish', 3, 3);

-- Execute query using test table
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(query_name), 2) AS quality,
    ROUND(((SUM(rating < 3))/COUNT(query_name)) * 100, 2) AS poor_query_percentage
FROM
    Queries_test5 
GROUP BY
    query_name;