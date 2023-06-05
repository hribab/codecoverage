-- Create a test table and insert sample records
CREATE TABLE testProducts (
    product_id INT PRIMARY KEY,
    low_fats ENUM('Y','N'),
    recyclable ENUM('Y','N')
);

INSERT INTO testProducts (product_id, low_fats, recyclable) VALUES
    (1, 'Y', 'Y'),
    (2, 'Y', 'N'),
    (3, 'N', 'Y'),
    (4, 'N', 'N'),
    (5, 'Y', 'Y');


-- Test case 1
-- Test for at least one low fat and recyclable product
SELECT product_id FROM testProducts WHERE low_fats = 'Y' AND recyclable = 'Y';
-- Expected output: 1, 5

-- Test case 2
-- Test for no low fat products
UPDATE testProducts SET low_fats = 'N';
SELECT product_id FROM testProducts WHERE low_fats = 'Y' AND recyclable = 'Y';
-- Expected output: 0 records

-- Test case 3
-- Test for no recyclable products
UPDATE testProducts SET low_fats = 'Y', recyclable = 'N';
SELECT product_id FROM testProducts WHERE low_fats = 'Y' AND recyclable = 'Y';
-- Expected output: 0 records

-- Test case 4
-- Test all products as low fat and recyclable
UPDATE testProducts SET low_fats = 'Y', recyclable = 'Y';
SELECT product_id FROM testProducts WHERE low_fats = 'Y' AND recyclable = 'Y';
-- Expected output: 1, 2, 3, 4, 5

-- Test case 5
-- Test all low fat products but none are recyclable
UPDATE testProducts SET low_fats = 'Y', recyclable = 'N' WHERE product_id IN(1, 5);
SELECT product_id FROM testProducts WHERE low_fats = 'Y' AND recyclable = 'Y';
-- Expected output: 0 records

-- Clean up: Drop the test table
DROP TABLE testProducts;