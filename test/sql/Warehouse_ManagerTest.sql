-- Test case 1: Test with the provided example
INSERT INTO Warehouse (name, product_id, units)
VALUES ('LCHouse1', 1, 1),
       ('LCHouse1', 2, 10),
       ('LCHouse1', 3, 5),
       ('LCHouse2', 1, 2),
       ('LCHouse2', 2, 2),
       ('LCHouse3', 4, 1);

INSERT INTO Products (product_id, product_name, Width, Length, Height)
VALUES (1, 'LC-TV', 5, 50, 40),
       (2, 'LC-KeyChain', 5, 5, 5),
       (3, 'LC-Phone', 2, 10, 10),
       (4, 'LC-T-Shirt', 4, 10, 20);

-- Expected output:
-- +----------------+------------+
-- | warehouse_name | volume     |
-- +----------------+------------+
-- | LCHouse1       | 12250      |
-- | LCHouse2       | 20250      |
-- | LCHouse3       | 800        |
-- +----------------+------------+

-- Test case 2: Test with empty Warehouse table
TRUNCATE TABLE Warehouse;

-- Expected output: Empty resultSet

-- Test case 3: Test with empty Products table
TRUNCATE TABLE Products;

INSERT INTO Warehouse (name, product_id, units)
VALUES ('LCHouse1', 1, 1),
       ('LCHouse1', 2, 10),
       ('LCHouse1', 3, 5),
       ('LCHouse2', 1, 2),
       ('LCHouse2', 2, 2),
       ('LCHouse3', 4, 1);

-- Expected output: Empty resultSet

-- Test case 4: Test with one warehouse and one product
TRUNCATE TABLE Warehouse;
TRUNCATE TABLE Products;

INSERT INTO Warehouse (name, product_id, units)
VALUES ('LCHouse1', 1, 1);

INSERT INTO Products (product_id, product_name, Width, Length, Height)
VALUES (1, 'LC-TV', 5, 50, 40);

-- Expected output:
-- +----------------+--------+
-- | warehouse_name | volume |
-- +----------------+--------+
-- | LCHouse1       | 10000  |
-- +----------------+--------+

-- Test case 5: Test with warehouses having all products with same volume
TRUNCATE TABLE Warehouse;
TRUNCATE TABLE Products;

INSERT INTO Warehouse (name, product_id, units)
VALUES ('LCHouse1', 1, 1),
       ('LCHouse1', 2, 10),
       ('LCHouse1', 3, 5),
       ('LCHouse2', 1, 2),
       ('LCHouse2', 2, 2),
       ('LCHouse3', 4, 1);

INSERT INTO Products (product_id, product_name, Width, Length, Height)
VALUES (1, 'LC-TV', 1, 1, 1),
       (2, 'LC-KeyChain', 1, 1, 1),
       (3, 'LC-Phone', 1, 1, 1),
       (4, 'LC-T-Shirt', 1, 1, 1);

-- Expected output:
-- +----------------+--------+
-- | warehouse_name | volume |
-- +----------------+--------+
-- | LCHouse1       | 16     |
-- | LCHouse2       | 4      |
-- | LCHouse3       | 1      |
-- +----------------+--------+