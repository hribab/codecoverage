-- Test case 1: Basic test with one country meeting both area and population criteria
INSERT INTO world (name, continent, area, population, gdp) VALUES ('LargeCountry1', 'Continent1', 3500000, 30000000, 5000000000);
-- Expected output: LargeCountry1, 30000000, 3500000

-- Test case 2: Basic test with one country meeting only area criteria
INSERT INTO world (name, continent, area, population, gdp) VALUES ('LargeCountry2', 'Continent2', 4500000, 20000000, 6000000000);
-- Expected output: LargeCountry2, 20000000, 4500000

-- Test case 3: Basic test with one country meeting only population criteria
INSERT INTO world (name, continent, area, population, gdp) VALUES ('LargeCountry3', 'Continent3', 2500000, 35000000, 7000000000);
-- Expected output: LargeCountry3, 35000000, 2500000

-- Test case 4: Basic test with a country not meeting either area or population criteria
INSERT INTO world (name, continent, area, population, gdp) VALUES ('SmallCountry1', 'Continent4', 2500000, 20000000, 4000000000);
-- Expected output: No results

-- Test case 5: Test with multiple large countries in the table
INSERT INTO world (name, continent, area, population, gdp) VALUES ('LargeCountry4', 'Continent5', 5500000, 40000000, 8000000000);
INSERT INTO world (name, continent, area, population, gdp) VALUES ('LargeCountry5', 'Continent6', 6000000, 45000000, 9000000000);
-- Expected output: LargeCountry4, 40000000, 5500000 and LargeCountry5, 45000000, 6000000

-- Remember to clean up the test data after each test case
DELETE FROM world;