-- Create test table
CREATE TABLE Sales_test 
    (sale_date DATE,
    fruit ENUM('apples', 'oranges'),
    sold_num INT,
    PRIMARY KEY (sale_date, fruit));

-- Test Case 1: Basic test case
/*
This test case has normal sales data with different number of apples and oranges sold each day.
Expected output is the difference of apples and oranges sold_num on each day.
*/
INSERT INTO Sales_test VALUES 
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 0),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);

SELECT
    s1.sale_date,
    s1.sold_num - s2.sold_num AS diff
FROM Sales_test s1, Sales_test s2
WHERE
    s1.sale_date = s2.sale_date
    AND s1.fruit = 'apples'
    AND s2.fruit = 'oranges';

-- Test Case 2: No data in table
/*
This test case checks if the code handles an empty table situation.
Expected output is an empty table since there are no apples or oranges.
*/
DELETE FROM Sales_test;

SELECT
    s1.sale_date,
    s1.sold_num - s2.sold_num AS diff
FROM Sales_test s1, Sales_test s2
WHERE
    s1.sale_date = s2.sale_date
    AND s1.fruit = 'apples'
    AND s2.fruit = 'oranges';

-- Test Case 3: All days have equal apples and oranges sales
/*
This test case checks if the code handles a situation where apples and oranges sold are equal on all days.
Expected output should have difference as '0' for all days.
*/
INSERT INTO Sales_test VALUES 
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 10),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 20),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 15);

SELECT
    s1.sale_date,
    s1.sold_num - s2.sold_num AS diff
FROM Sales_test s1, Sales_test s2
WHERE
    s1.sale_date = s2.sale_date
    AND s1.fruit = 'apples'
    AND s2.fruit = 'oranges';

-- Test Case 4: Different days are missing fruit data
/*
This test case checks if the code handles a situation where some fruit sales data is missing.
Expected output is the difference of apples and oranges sold_num on each day with available data.
*/
DELETE FROM Sales_test;

INSERT INTO Sales_test VALUES 
    ('2020-05-01', 'apples', 10),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);

SELECT
    s1.sale_date,
    s1.sold_num - s2.sold_num AS diff
FROM Sales_test s1, Sales_test s2
WHERE
    s1.sale_date = s2.sale_date
    AND s1.fruit = 'apples'
    AND s2.fruit = 'oranges';

-- Test Case 5: Only one day of data
/*
This test case checks if the code handles a situation of only one day of data
Expected output is the difference of apples and oranges sold_num on that day.
*/
DELETE FROM Sales_test;

INSERT INTO Sales_test VALUES 
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8);

SELECT
    s1.sale_date,
    s1.sold_num - s2.sold_num AS diff
FROM Sales_test s1, Sales_test s2
WHERE
    s1.sale_date = s2.sale_date
    AND s1.fruit = 'apples'
    AND s2.fruit = 'oranges';

-- Clean up
DROP TABLE Sales_test;