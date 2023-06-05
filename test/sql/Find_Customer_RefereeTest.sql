-- Test case 1: Basic case where there is no referral made by customer with id=2
INSERT INTO Customer (id, name, referee_id) VALUES (1, 'Alice', NULL), (2, 'Bob', NULL), (3, 'Carol', 1), (4, 'David', 1);
/* Expected Output: Alice, Bob, Carol, and David */

-- Test case 2: Basic case where there is a valid referral made by customer with id=2
INSERT INTO Customer (id, name, referee_id) VALUES (1, 'Alice', NULL), (2, 'Bob', NULL), (3, 'Carol', 1), (4, 'David', 2);
/* Expected Output: Alice, Bob, and Carol */

-- Test case 3: Case where all customer referrals are made by customer with id=2
INSERT INTO Customer (id, name, referee_id) VALUES (1, 'Alice', NULL), (2, 'Bob', NULL), (3, 'Carol', 2), (4, 'David', 2);
/* Expected Output: Alice, and Bob */

-- Test case 4: Case with only one customer in the table
INSERT INTO Customer (id, name, referee_id) VALUES (1, 'Alice', NULL);
/* Expected Output: Alice */

-- Test case 5: Case with no customers in the table (empty table)
/* Expected Output: */