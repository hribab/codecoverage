-- Unit Test 1: Test with empty DailySales table
-- Insert 0 records into DailySales table
-- Expected Output: Empty result with no rows
BEGIN;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES 
();
SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) as unique_leads, COUNT(DISTINCT(partner_id)) as unique_partners 
FROM DailySales 
GROUP BY date_id, make_name;
ROLLBACK;

-- Unit Test 2: Test DailySales record with only one row
-- Insert 1 record into DailySales table
-- Expected Output: corresponding data of the inserted row
BEGIN;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES 
('2021-10-01', 'productA', 1, 101);
SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) as unique_leads, COUNT(DISTINCT(partner_id)) as unique_partners 
FROM DailySales 
GROUP BY date_id, make_name;
ROLLBACK;

-- Unit Test 3: Test DailySales records with multiple rows, different date_id, different make_name
-- Insert 4 records into DailySales table with different date_id and make_name
-- Expected Output: all the 4 records should be shown in the result with unique_leads and unique_partners as 1
BEGIN;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES 
('2021-10-01', 'productA', 1, 101),
('2021-10-01', 'productB', 2, 103),
('2021-10-02', 'productA', 3, 102),
('2021-10-03', 'productB', 4, 104);
SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) as unique_leads, COUNT(DISTINCT(partner_id)) as unique_partners 
FROM DailySales 
GROUP BY date_id, make_name;
ROLLBACK;

-- Unit Test 4: Test DailySales records with multiple rows, same date_id, different make_name
-- Insert 3 records into DailySales table with same date_ids but different make_name
-- Expected Output: one row for each make_name with unique_leads and unique_partners as 1
BEGIN;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES 
('2021-10-01', 'productA', 1, 101),
('2021-10-01', 'productB', 2, 103),
('2021-10-01', 'productC', 3, 102);
SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) as unique_leads, COUNT(DISTINCT(partner_id)) as unique_partners 
FROM DailySales 
GROUP BY date_id, make_name;
ROLLBACK;

-- Unit Test 5: Test DailySales records with multiple rows, same date_id, same make_name
-- Insert 4 records into DailySales table with same date_id and make_name
-- Expected Output: one row for each make_name with unique_leads and unique_partners as the number of distinct lead_id and partner_id
BEGIN;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES 
('2021-10-01', 'productA', 1, 101),
('2021-10-01', 'productA', 2, 103),
('2021-10-01', 'productA', 2, 102),
('2021-10-01', 'productA', 1, 102);
SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) as unique_leads, COUNT(DISTINCT(partner_id)) as unique_partners 
FROM DailySales 
GROUP BY date_id, make_name;
ROLLBACK;