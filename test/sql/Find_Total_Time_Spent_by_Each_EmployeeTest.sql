-- Unit Test 1: Test if the function returns the correct total time for a single entry on a single day
/*
Input:
(1, '2022-02-01', 100, 200),
(1, '2022-02-01', 220, 400),
(2, '2022-02-01', 300, 600)
Output: 
('2022-02-01', 1, 280),
('2022-02-01', 2, 300)
*/
INSERT INTO Employees (emp_id, event_day, in_time, out_time)
VALUES 
(1, '2022-02-01', 100, 200),
(1, '2022-02-01', 220, 400),
(2, '2022-02-01', 300, 600);

SELECT * FROM ../sql/Find_Total_Time_Spent_by_Each_Employee.sql;

-- Unit Test 2: Test if the function handles multiple days correctly
/*
Input:
(1, '2022-02-01', 100, 200),
(1, '2022-02-02', 150, 250),
(2, '2022-02-01', 300, 600),
(2, '2022-02-02', 350, 750)
Output: 
('2022-02-01', 1, 100),
('2022-02-02', 1, 100),
('2022-02-01', 2, 300),
('2022-02-02', 2, 400)
*/
DELETE FROM Employees;

INSERT INTO Employees (emp_id, event_day, in_time, out_time)
VALUES 
(1, '2022-02-01', 100, 200),
(1, '2022-02-02', 150, 250),
(2, '2022-02-01', 300, 600),
(2, '2022-02-02', 350, 750);

SELECT * FROM ../sql/Find_Total_Time_Spent_by_Each_Employee.sql;

-- Unit Test 3: Test if the function handles the minimum and maximum in_time and out_time correctly
/*
Input:
(1, '2022-02-01', 1, 1440)
Output: 
('2022-02-01', 1, 1439)
*/
DELETE FROM Employees;

INSERT INTO Employees (emp_id, event_day, in_time, out_time)
VALUES 
(1, '2022-02-01', 1, 1440);

SELECT * FROM ../sql/Find_Total_Time_Spent_by_Each_Employee.sql;

-- Unit Test 4: Test if the function handles an employee entering and leaving multiple times on a single day
/*
Input:
(1, '2022-02-01', 100, 200),
(1, '2022-02-01', 300, 400),
(1, '2022-02-01', 500, 600)
Output: 
('2022-02-01', 1, 300)
*/
DELETE FROM Employees;

INSERT INTO Employees (emp_id, event_day, in_time, out_time)
VALUES 
(1, '2022-02-01', 100, 200),
(1, '2022-02-01', 300, 400),
(1, '2022-02-01', 500, 600);

SELECT * FROM ../sql/Find_Total_Time_Spent_by_Each_Employee.sql;

-- Unit Test 5: Test if the function returns an empty result for an empty Employees table
/*
Output: 
(empty result)
*/
DELETE FROM Employees;

SELECT * FROM ../sql/Find_Total_Time_Spent_by_Each_Employee.sql;