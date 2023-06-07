-- Create a sample Products table for testing purposes
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    store1 INT,
    store2 INT,
    store3 INT
);

-- Insert sample data into the Products table
INSERT INTO Products (product_id, store1, store2, store3)
VALUES (1, 10, 20, 30),
       (2, 15, NULL, 25),
       (3, NULL, NULL, 35),
       (4, 40, 45, NULL),
       (5, NULL, 50, 55);

-- Test case 1: Check if the query returns correct store and price values for each product_id
SELECT product_id, store, price
FROM (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
    UNION
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
    UNION
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
) AS rearranged
ORDER BY product_id, store;

-- Test case 2: Check if rows with NULL prices are excluded from the result
SELECT COUNT(*)
FROM (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
    UNION
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
    UNION
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
) AS rearranged
WHERE price IS NULL;

-- Test case 3: Check if the total number of rows returned is correct
SELECT COUNT(*)
FROM (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
    UNION
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
    UNION
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
) AS rearranged;

-- Test case 4: Add a new product to the Products table and check if it's properly included in the output
INSERT INTO Products (product_id, store1, store2, store3)
VALUES (6, NULL, 60, NULL);

SELECT product_id, store, price
FROM (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
    UNION
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
    UNION
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
) AS rearranged
WHERE product_id = 6;

-- Test case 5: Update an existing product's prices and check if the output reflects the changes
UPDATE Products
SET store1 = 12, store2 = 22, store3 = 32
WHERE product_id = 1;

SELECT product_id, store, price
FROM (
    SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
    UNION
    SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
    UNION
    SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
) AS rearranged
WHERE product_id = 1;