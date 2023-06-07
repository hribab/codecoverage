-- Test case 1: Test with an empty database
-- Expect: An empty result set since there are no salespersons in the database

rollback;
begin;
SELECT * FROM SalesPerson;
SELECT * FROM Orders;
SELECT * FROM Company;

select name from SalesPerson where sales_id not in
(select sales_id from Orders where com_id = (select com_id from Company where name ='RED'));

rollback;


-- Test case 2: Test with one salesperson without any company
-- Expect: The name of salesperson1 since he didn't have any orders related to RED company

rollback;
begin;

INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'salesperson1', 1000, 5, '2020-01-01');

SELECT * FROM SalesPerson;
SELECT * FROM Orders;
SELECT * FROM Company;

select name from SalesPerson where sales_id not in
(select sales_id from Orders where com_id = (select com_id from Company where name ='RED'));

rollback;


-- Test case 3: Test with one salesperson and one company not named RED
-- Expect: The name of salesperson1 since he didn't have any orders related to RED company

rollback;
begin;

INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'salesperson1', 1000, 5, '2020-01-01');
INSERT INTO Company (com_id, name, city) VALUES (1, 'Not RED', 'Some city');

SELECT * FROM SalesPerson;
SELECT * FROM Orders;
SELECT * FROM Company;

select name from SalesPerson where sales_id not in
(select sales_id from Orders where com_id = (select com_id from Company where name ='RED'));

rollback;


-- Test case 4: Test with one salesperson and two companies, one named RED
-- Expect: The name of salesperson1 since he didn't have any orders related to RED company

rollback;
begin;

INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'salesperson1', 1000, 5, '2020-01-01');
INSERT INTO Company (com_id, name, city) VALUES (1, 'Not RED', 'Some city');
INSERT INTO Company (com_id, name, city) VALUES (2, 'RED', 'Another city');

SELECT * FROM SalesPerson;
SELECT * FROM Orders;
SELECT * FROM Company;

select name from SalesPerson where sales_id not in
(select sales_id from Orders where com_id = (select com_id from Company where name ='RED'));

rollback;


-- Test case 5: Test with multiple salespersons with and without orders related to RED company
-- Expect: The names of salesperson1, salesperson2, salesperson4 since they didn't have any orders related to RED company

rollback;
begin;

INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'salesperson1', 1000, 5, '2020-01-01');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'salesperson2', 1200, 6, '2020-01-02');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'salesperson3', 1100, 5, '2020-01-03');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'salesperson4', 1300, 7, '2020-01-04');
INSERT INTO Company (com_id, name, city) VALUES (1, 'Not RED', 'Some city');
INSERT INTO Company (com_id, name, city) VALUES (2, 'RED', 'Another city');
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (1, '2020-01-10', 1, 1, 100);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (2, '2020-01-12', 1, 2, 200);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES (3, '2020-01-15', 2, 3, 300);

SELECT * FROM SalesPerson;
SELECT * FROM Orders;
SELECT * FROM Company;

SELECT name FROM SalesPerson WHERE sales_id NOT IN
(SELECT sales_id FROM Orders WHERE com_id = (SELECT com_id FROM Company WHERE name ='RED'));

rollback;