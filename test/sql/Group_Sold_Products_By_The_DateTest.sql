-- Test case 1: Test with no data
-- Expected output: empty result set
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-15', 'NoData');
DELETE FROM Activities WHERE sell_date = '2022-02-15';

-- Test case 2: Test with one product sold on one date
-- Expected output: sell_date: 2022-02-15, num_sold: 1, products: Laptop
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-15', 'Laptop');

-- Test case 3: Test with multiple products sold on one date
-- Expected output: sell_date: 2022-02-15, num_sold: 3, products: Laptop,Mouse,Keyboard
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-15', 'Mouse');
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-15', 'Keyboard');

-- Test case 4: Test with multiple products sold on multiple dates
-- Expected output: 
-- sell_date: 2022-02-15, num_sold: 3, products: Laptop,Mouse,Keyboard
-- sell_date: 2022-02-16, num_sold: 2, products: Monitor,Smartphone
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-16', 'Monitor');
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-16', 'Smartphone');

-- Test case 5: Test with duplicate products sold on the same date
-- Expected output: 
-- sell_date: 2022-02-15, num_sold: 3, products: Laptop,Mouse,Keyboard
-- sell_date: 2022-02-16, num_sold: 2, products: Monitor,Smartphone
-- sell_date: 2022-02-17, num_sold: 1, products: Headphones
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-17', 'Headphones');
INSERT INTO Activities (sell_date, product) VALUES ('2022-02-17', 'Headphones');