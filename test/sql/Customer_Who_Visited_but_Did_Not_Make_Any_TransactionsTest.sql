-- Unit test code for the provided PLSQL code

-- Test Case 1: Check if the returned result is correct with sample data
/*
Data Setup:
Visits:          Transactions:
visit_id | customer_id    transaction_id | visit_id | amount
---------|------------    ---------------|----------|-------
1        | 1                              1         | 1       | 100
2        | 2                              2         | 2       | 200
3        | 2                              3         | 3       | 300
4        | 1                              
5        | 3

Expected Result: customer_id | count_no_trans
                 ------------|--------------
                 1           | 1
                 3           | 1
*/
BEGIN
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (5, 3);

INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 100);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 2, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (3, 3, 300);

SELECT * FROM (
    SELECT customer_id, count(visit_id) as count_no_trans FROM Visits WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
    GROUP BY customer_id
) as test WHERE customer_id = 1 AND count_no_trans = 1 AND customer_id = 3 AND count_no_trans = 1;
END;

-- Test Case 2: Check if the function returns an empty result when all customers have made transactions
/*
Data Setup:
Visits:          Transactions:
visit_id | customer_id    transaction_id | visit_id | amount
---------|------------    ---------------|----------|-------
1        | 1                              1         | 1       | 100
2        | 2                              2         | 2       | 200
3        | 2                              3         | 3       | 300

Expected Result: (Empty)
*/
BEGIN
DELETE FROM Visits;
DELETE FROM Transactions;

INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 2);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 100);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 2, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (3, 3, 300);

SELECT * FROM (
    SELECT customer_id, count(visit_id) as count_no_trans FROM Visits WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
    GROUP BY customer_id
) as test;
END;

-- Test Case 3: check if the function returns correct result when no customers have visited the mall
/*
Data Setup: (Empty Visits and Transactions)

Expected Result: (Empty)
*/
BEGIN
DELETE FROM Visits;
DELETE FROM Transactions;

SELECT * FROM (
    SELECT customer_id, count(visit_id) as count_no_trans FROM Visits WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
    GROUP BY customer_id
) as test;
END;

-- Test Case 4: Check if the function returns correct result when only one customer has not made any transactions multiple times
/*
Data Setup:
Visits:          Transactions:
visit_id | customer_id    transaction_id | visit_id | amount
---------|------------    ---------------|----------|-------
1        | 1                              1         | 1       | 100
2        | 1                              2         | 2       | 200
3        | 1                              3         | 3       | 300
4        | 2
5        | 2
6        | 2

Expected Result: customer_id | count_no_trans
                 ------------|--------------
                 2           | 3
*/
BEGIN
DELETE FROM Visits;
DELETE FROM Transactions;

INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (5, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (6, 2);

INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 100);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 2, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (3, 3, 300);

SELECT * FROM (
    SELECT customer_id, count(visit_id) as count_no_trans FROM Visits WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
    GROUP BY customer_id
) as test WHERE customer_id = 2 AND count_no_trans = 3;
END;

-- Test Case 5: Check if the function returns correct result when all customers have visited without making any transactions
/*
Data Setup:
Visits:          Transactions:
visit_id | customer_id    (Empty)
---------|------------    
1        | 1                           
2        | 2                             
3        | 3                          

Expected Result: customer_id | count_no_trans
                 ------------|--------------
                 1           | 1                              
                 2           | 1
                 3           | 1
*/
BEGIN
DELETE FROM Visits;
DELETE FROM Transactions;

INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 3);
SELECT * FROM (
    SELECT customer_id, count(visit_id) as count_no_trans FROM Visits WHERE visit_id NOT IN (SELECT visit_id FROM Transactions)
    GROUP BY customer_id
) as test WHERE customer_id = 1 AND count_no_trans = 1 AND customer_id = 2 AND count_no_trans = 1 AND customer_id = 3 AND count_no_trans = 1;
END;
