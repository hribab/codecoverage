-- Test code for Combine_Two_Tables.sql

-- Test Case 1: Basic test with only one record in each table
BEGIN;
    INSERT INTO Person (personId, lastName, firstName) VALUES (1, 'Doe', 'John');
    INSERT INTO Address (addressId, personId, city, state) VALUES (1, 1, 'New York', 'NY');
    SELECT firstName, lastName, city, state FROM Person LEFT JOIN Address ON Person.personId = Address.personId;
    ROLLBACK;

-- Test Case 2: Test with multiple records in each table, including records without matching IDs
BEGIN;
    INSERT INTO Person (personId, lastName, firstName) VALUES (1, 'Doe', 'John'), (2, 'Smith', 'Jane'), (3, 'Brown', 'Bob');
    INSERT INTO Address (addressId, personId, city, state) VALUES (1, 1, 'New York', 'NY'), (2, 2, 'Los Angeles', 'CA'), (4, 4, 'Chicago', 'IL');
    SELECT firstName, lastName, city, state FROM Person LEFT JOIN Address ON Person.personId = Address.personId;
    ROLLBACK;

-- Test Case 3: Test with no records in Address table
BEGIN;
    DELETE FROM Address;
    SELECT firstName, lastName, city, state FROM Person LEFT JOIN Address ON Person.personId = Address.personId;
    ROLLBACK;

-- Test Case 4: Test with no records in Person table
BEGIN;
    DELETE FROM Person;
    SELECT firstName, lastName, city, state FROM Person LEFT JOIN Address ON Person.personId = Address.personId;
    ROLLBACK;

-- Test Case 5: Test with both tables having records only for different IDs
BEGIN;
    DELETE FROM Person;
    DELETE FROM Address;
    INSERT INTO Person (personId, lastName, firstName) VALUES (1, 'Doe', 'John'), (2, 'Smith', 'Jane');
    INSERT INTO Address (addressId, personId, city, state) VALUES (3, 3, 'San Francisco', 'CA'), (4, 4, 'Chicago', 'IL');
    SELECT firstName, lastName, city, state FROM Person LEFT JOIN Address ON Person.personId = Address.personId;
    ROLLBACK;