-- Create table and insert sample data
CREATE TABLE Delivery (
  delivery_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  customer_pref_delivery_date DATE
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
  (1, 1, '2019-08-01', '2019-08-02'),
  (2, 5, '2019-08-02', '2019-08-02'),
  (3, 1, '2019-08-11', '2019-08-11'),
  (4, 3, '2019-08-24', '2019-08-26'),
  (5, 4, '2019-08-21', '2019-08-22'),
  (6, 2, '2019-08-11', '2019-08-13');

-- Test case 1: Check if immediate_percentage is calculated correctly
SELECT CASE
         WHEN immediate_percentage = 33.33 THEN 'PASS'
         ELSE 'FAIL'
       END AS result
FROM
  (SELECT ROUND((SUM(order_date = customer_pref_delivery_date) / COUNT(order_date)) * 100, 2) AS immediate_percentage
   FROM Delivery) t1;

-- Test case 2: Add one more immediate delivery
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
  (7, 6, '2019-08-25', '2019-08-25');

SELECT CASE
         WHEN immediate_percentage = 42.86 THEN 'PASS'
         ELSE 'FAIL'
       END AS result
FROM
  (SELECT ROUND((SUM(order_date = customer_pref_delivery_date) / COUNT(order_date)) * 100, 2) AS immediate_percentage
   FROM Delivery) t2;

-- Test case 3: Add two more scheduled deliveries
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
  (8, 7, '2019-08-25', '2019-08-26'),
  (9, 8, '2019-08-20', '2019-08-22');

SELECT CASE
         WHEN immediate_percentage = 33.33 THEN 'PASS'
         ELSE 'FAIL'
       END AS result
FROM
  (SELECT ROUND((SUM(order_date = customer_pref_delivery_date) / COUNT(order_date)) * 100, 2) AS immediate_percentage
   FROM Delivery) t3;

-- Test case 4: Add another immediate delivery
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
  (10, 9, '2019-08-15', '2019-08-15');

SELECT CASE
         WHEN immediate_percentage = 37.5 THEN 'PASS'
         ELSE 'FAIL'
       END AS result
FROM
  (SELECT ROUND((SUM(order_date = customer_pref_delivery_date) / COUNT(order_date)) * 100, 2) AS immediate_percentage
   FROM Delivery) t4;

-- Test case 5: Empty table
TRUNCATE TABLE Delivery;

SELECT CASE
         WHEN immediate_percentage = 0 THEN 'PASS'
         ELSE 'FAIL'
       END AS result
FROM
  (SELECT ROUND((SUM(order_date = customer_pref_delivery_date) / COUNT(order_date)) * 100, 2) AS immediate_percentage
   FROM Delivery) t5;