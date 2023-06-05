-- Unit Test Case 1: Test single customer with single order
/*
This test case aims to check if the function returns the correct
customer_number when the table has only one record.
*/
INSERT INTO Orders(order_number, customer_number) VALUES(1, 100);
SELECT customer_number FROM (SELECT customer_number, COUNT(customer_number) AS c FROM Orders
GROUP BY customer_number ORDER BY c DESC LIMIT 1) AS max_table;
DELETE FROM Orders WHERE order_number = 1;

-- Unit Test Case 2: Test multiple customers with one customer having more orders than others
/*
This test case aims to check if the function returns the correct
customer_number when the table has multiple records.
*/
INSERT INTO Orders(order_number, customer_number) VALUES(1, 100),(2, 100),(3, 200),(4, 200),(5, 200),(6, 300);
SELECT customer_number FROM (SELECT customer_number, COUNT(customer_number) AS c FROM Orders
GROUP BY customer_number ORDER BY c DESC LIMIT 1) AS max_table;
DELETE FROM Orders WHERE order_number IN (1, 2, 3, 4, 5, 6);

-- Unit Test Case 3: Test consecutive customer numbers with same number of orders
/*
This test case aims to check if the function returns the correct
customer_number when there is a tie between customer_number.
*/
INSERT INTO Orders(order_number, customer_number) VALUES(1, 100),(2, 100),(3, 200),(4, 200);
SELECT customer_number FROM (SELECT customer_number, COUNT(customer_number) AS c FROM Orders
GROUP BY customer_number ORDER BY c DESC LIMIT 1) AS max_table;
DELETE FROM Orders WHERE order_number IN (1, 2, 3, 4);

-- Unit Test Case 4: Test non-consecutive customer numbers
/*
This test case aims to check if the function works correctly when
there are non-consecutive customer numbers
*/
INSERT INTO Orders(order_number, customer_number) VALUES(1, 100),(2, 102),(3, 104),(4, 104),(5, 104),(6, 108);
SELECT customer_number FROM (SELECT customer_number, COUNT(customer_number) AS c FROM Orders
GROUP BY customer_number ORDER BY c DESC LIMIT 1) AS max_table;
DELETE FROM Orders WHERE order_number IN (1, 2, 3, 4, 5, 6);

-- Unit Test Case 5: Test customers with no orders
/*
This test case aims to check if the function returns NULL when there are no orders in the table
*/
SELECT customer_number FROM (SELECT customer_number, COUNT(customer_number) AS c FROM Orders
GROUP BY customer_number ORDER BY c DESC LIMIT 1) AS max_table;