-- Test code for the Capital Gain/Loss query

-- Prepare test data
CREATE TABLE IF NOT EXISTS Stocks (
  stock_name VARCHAR,
  operation ENUM('Sell', 'Buy'),
  operation_day INT,
  price INT,
  PRIMARY KEY(stock_name, operation_day)
);

TRUNCATE TABLE Stocks;

-- Test Case 1: Simple test case with one stock and one Buy and Sell operation
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES
  ('A', 'Buy', 1, 100),
  ('A', 'Sell', 2, 200);

-- Test Case 2: Simple test case with negative capital_gain_loss
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES
  ('B', 'Buy', 1, 200),
  ('B', 'Sell', 2, 100);

-- Test Case 3: Test case with multiple Buy and Sell operations
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES
  ('C', 'Buy', 1, 100),
  ('C', 'Buy', 2, 200),
  ('C', 'Sell', 3, 300),
  ('C', 'Sell', 4, 200);

-- Test Case 4: Test case with multiple stocks
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES
  ('D', 'Buy', 1, 50),
  ('D', 'Sell', 2, 100),
  ('E', 'Buy', 1, 100),
  ('E', 'Buy', 2, 200),
  ('E', 'Sell', 3, 400);

-- Test Case 5: Test case with no capital_gain_loss
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES
  ('F', 'Buy', 1, 50),
  ('F', 'Sell', 2, 50);

-- Execute the query to test the test cases
SELECT
  stock_name, SUM(IF(operation='Buy', -1*price, price)) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
ORDER BY capital_gain_loss DESC;