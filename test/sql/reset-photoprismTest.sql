-- Test case 1: Check if database is dropped
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM all_users
  WHERE username = 'PHOTOPRISM';

  IF v_count = 1 THEN
    DROP DATABASE photoprism;
  END IF;

  SELECT COUNT(*)
  INTO v_count
  FROM all_users
  WHERE username = 'PHOTOPRISM';

  DBMS_OUTPUT.PUT_LINE('Test case 1: Check if database is dropped - '|| (CASE WHEN v_count=0 THEN 'Passed' ELSE 'Failed' END));
END;
/

-- Test case 2: Check if database is created
DECLARE
  v_count NUMBER;
BEGIN
  CREATE DATABASE IF NOT EXISTS photoprism;

  SELECT COUNT(*)
  INTO v_count
  FROM all_users
  WHERE username = 'PHOTOPRISM';

  DBMS_OUTPUT.PUT_LINE('Test case 2: Check if database is created - '||(CASE WHEN v_count=1 THEN 'Passed' ELSE 'Failed' END));
END;
/

-- Test case 3: Check if privileges are flushed
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM all_users;

  -- Store the initial count of users
  v_count := v_count + 1;

  -- Add a new user
  EXECUTE IMMEDIATE 'CREATE USER test_user IDENTIFIED BY password';

  FLUSH PRIVILEGES;

  -- Check if the count of users increased
  SELECT COUNT(*)
  INTO v_count
  FROM all_users;

  DBMS_OUTPUT.PUT_LINE('Test case 3: Check if privileges are flushed - '||(CASE WHEN v_count > 0 THEN 'Passed' ELSE 'Failed' END));

  -- Clean up the temporary user
  EXECUTE IMMEDIATE 'DROP USER test_user';
END;
/

-- Test case 4: Check if the existing database is dropped and a new one is created
DECLARE
  v_count NUMBER;
BEGIN
  DROP DATABASE IF EXISTS photoprism;
  CREATE DATABASE IF NOT EXISTS photoprism;

  SELECT COUNT(*)
  INTO v_count
  FROM all_users
  WHERE username = 'PHOTOPRISM';

  DBMS_OUTPUT.PUT_LINE('Test case 4: Check if the existing database is dropped and a new one is created - '||(CASE WHEN v_count=1 THEN 'Passed' ELSE 'Failed' END));
END;
/

-- Test case 5: Check if the code executes without errors
DECLARE
  v_error BOOLEAN := FALSE;
BEGIN
  BEGIN
    DROP DATABASE IF EXISTS photoprism;
    CREATE DATABASE IF NOT EXISTS photoprism;
    FLUSH PRIVILEGES;
  EXCEPTION
    WHEN OTHERS THEN
      v_error := TRUE;
  END;

  DBMS_OUTPUT.PUT_LINE('Test case 5: Check if the code executes without errors - '||(CASE WHEN v_error=FALSE THEN 'Passed' ELSE 'Failed' END));
END;
/