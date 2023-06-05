-- Test code for PLSQL code

-- Test Case 1: Basic test to check if the query returns correct first_login date for each player
DECLARE 
  v_player_id Activity.player_id%TYPE := 1;
  v_device_id Activity.device_id%TYPE := 101;
  v_event_date_1 Activity.event_date%TYPE := '2022-01-01';
  v_event_date_2 Activity.event_date%TYPE := '2022-01-02';
  v_games_played Activity.games_played%TYPE := 5;
  v_first_login date;
BEGIN
  -- Clean up the table before starting
  DELETE FROM Activity;

  -- Insert some test data
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id, v_device_id, v_event_date_1, v_games_played);
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id, v_device_id, v_event_date_2, v_games_played);

  -- Execute the query
  SELECT min(event_date) INTO v_first_login FROM Activity WHERE player_id = v_player_id GROUP BY player_id;

  -- Check if the first_login date is as expected
  IF v_first_login != v_event_date_1 THEN
    raise_application_error(-20001, 'Test Case 1 Failed. Expected: ' || v_event_date_1 || ', but got ' || v_first_login);
  END IF;

  DBMS_OUTPUT.PUT_LINE('Test Case 1 Passed');
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Test Case 1 Failed. ' || SQLERRM);
END;
/


-- Test Case 2: Check if the query returns correct result when there are multiple players
DECLARE
  v_player_id_1 Activity.player_id%TYPE := 1;
  v_player_id_2 Activity.player_id%TYPE := 2;
  v_device_id_1 Activity.device_id%TYPE := 101;
  v_device_id_2 Activity.device_id%TYPE := 102;
  v_event_date_1 Activity.event_date%TYPE := '2022-01-01';
  v_event_date_2 Activity.event_date%TYPE := '2022-01-02';
  v_games_played Activity.games_played%TYPE := 5;
  v_first_login_1 date;
  v_first_login_2 date;
BEGIN
  -- Clean up the table before starting
  DELETE FROM Activity;

  -- Insert some test data
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id_1, v_device_id_1, v_event_date_1, v_games_played);
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id_2, v_device_id_2, v_event_date_2, v_games_played);

  -- Execute the query for player 1
  SELECT min(event_date) INTO v_first_login_1 FROM Activity WHERE player_id = v_player_id_1 GROUP BY player_id;

  -- Check if the first_login date is as expected for player 1
  IF v_first_login_1 != v_event_date_1 THEN
    raise_application_error(-20001, 'Test Case 2 Failed for player 1. Expected: ' || v_event_date_1 || ', but got ' || v_first_login_1);
  END IF;

  -- Execute the query for player 2
  SELECT min(event_date) INTO v_first_login_2 FROM Activity WHERE player_id = v_player_id_2 GROUP BY player_id;

  -- Check if the first_login date is as expected for player 2
  IF v_first_login_2 != v_event_date_2 THEN
    raise_application_error(-20001, 'Test Case 2 Failed for player 2. Expected: ' || v_event_date_2 || ', but got ' || v_first_login_2);
  END IF;

  DBMS_OUTPUT.PUT_LINE('Test Case 2 Passed');
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Test Case 2 Failed. ' || SQLERRM);
END;
/


-- Test Case 3: Check if the query returns correct result when there are no games played
DECLARE
  v_player_id Activity.player_id%TYPE := 1;
  v_device_id_1 Activity.device_id%TYPE := 101;
  v_event_date_1 Activity.event_date%TYPE := '2022-01-01';
  v_games_played Activity.games_played%TYPE := 0;
  v_first_login date;
BEGIN
  -- Clean up the table before starting
  DELETE FROM Activity;

  -- Insert some test data
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id, v_device_id_1, v_event_date_1, v_games_played);

  -- Execute the query
  SELECT min(event_date) INTO v_first_login FROM Activity WHERE player_id = v_player_id GROUP BY player_id;

  -- Check if the first_login date is as expected when there are no games played
  IF v_first_login != v_event_date_1 THEN
    raise_application_error(-20001, 'Test Case 3 Failed. Expected: ' || v_event_date_1 || ', but got ' || v_first_login);
  END IF;

  DBMS_OUTPUT.PUT_LINE('Test Case 3 Passed');
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Test Case 3 Failed. ' || SQLERRM);
END;
/


-- Test Case 4: Check if the query returns nothing when there is no data in the table
DECLARE
  v_player_id Activity.player_id%TYPE := 1;
  v_first_login date;
BEGIN
  -- Clean up the table before starting
  DELETE FROM Activity;

  -- Execute the query
  BEGIN
    SELECT min(event_date) INTO v_first_login FROM Activity WHERE player_id = v_player_id GROUP BY player_id;

    -- Check if the first_login date is NULL when there is no data in the table
    IF v_first_login IS NOT NULL THEN
      raise_application_error(-20001, 'Test Case 4 Failed. Expected: NULL, but got ' || v_first_login);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Test Case 4 Passed');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Test Case 4 Passed. No data found as expected');
    WHEN OTHERS THEN
      raise_application_error(-20002, 'Test Case 4 Failed. ' || SQLERRM);
  END;
END;
/


-- Test Case 5: Check if the query handles duplicates correctly
DECLARE
  v_player_id Activity.player_id%TYPE := 1;
  v_device_id Activity.device_id%TYPE := 101;
  v_event_date Activity.event_date%TYPE := '2022-01-01';
  v_games_played Activity.games_played%TYPE := 5;
  v_first_login date;
BEGIN
  -- Clean up the table before starting
  DELETE FROM Activity;

  -- Insert some test data including duplicate rows
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id, v_device_id, v_event_date, v_games_played);
  INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES (v_player_id, v_device_id, v_event_date, v_games_played);

  -- Execute the query
  SELECT min(event_date) INTO v_first_login FROM Activity WHERE player_id = v_player_id GROUP BY player_id;

  -- Check if the first_login date is as expected when there are duplicate rows
  IF v_first_login != v_event_date THEN
    raise_application_error(-20001, 'Test Case 5 Failed. Expected: ' || v_event_date || ', but got ' || v_first_login);
  END IF;

  DBMS_OUTPUT.PUT_LINE('Test Case 5 Passed');
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Test Case 5 Failed. ' || SQLERRM);
END;
/