-- Test environment setup
CREATE TABLE Customers
(
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Orders
(
  id INT PRIMARY KEY,
  customerId INT REFERENCES Customers(id)
);

INSERT INTO Customers (id, name)
VALUES (1, 'John'), (2, 'Jane'), (3, 'Mark'), (4, 'Alice'), (5, 'Paul');

INSERT INTO Orders (id, customerId)
VALUES (1, 2), (2, 4), (3, 2), (4, 5), (5, 3);

-- Test case 1: Customers without orders
-- Result: John
select name as Customers from Customers where id not in (select customerId from Orders);

-- Test case 2: Customers with orders
-- Result: Jane, Mark, Alice, Paul
select name as Customers from Customers where id in (select customerId from Orders);

-- Test case 3: Total number of customers
-- Result: 5
select count(*) from Customers;

-- Test case 4: Total number of orders
-- Result: 5
select count(*) from Orders;

-- Test case 5: Customers with more than one order
-- Result: Jane
select name as Customers from Customers where id in
(select customerId from Orders group by customerId having count(*) > 1);

-- Cleanup
DROP TABLE Customers;
DROP TABLE Orders;