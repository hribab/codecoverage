DECLARE
    cnt NUMBER := 0;
	
BEGIN
    -- Test case 1: No data in the table
    DELETE FROM Activity;
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM (SELECT activity_date as day, COUNT(DISTINCT(user_id)) AS active_users
		FROM Activity
		WHERE activity_date BETWEEN ''2019-06-28'' AND ''2019-07-27''
		GROUP BY activity_date)';
    DBMS_OUTPUT.PUT_LINE('Test Case 1 (No data in the table):' || ' : ' || cnt);

    -- Test case 2: Single user with single activity
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 1, '2019-07-01', 'open_session');
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM (SELECT activity_date as day, COUNT(DISTINCT(user_id)) AS active_users
        FROM Activity
        WHERE activity_date BETWEEN ''2019-06-28'' AND ''2019-07-27''
        GROUP BY activity_date)';
    DBMS_OUTPUT.PUT_LINE('Test Case 2 (Single user with single activity):' || ' : ' || cnt);

    -- Test case 3: Single user with multiple activities on the same day
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 1, '2019-07-01', 'scroll_down');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 1, '2019-07-01', 'send_message');
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM (SELECT activity_date as day, COUNT(DISTINCT(user_id)) AS active_users
        FROM Activity
        WHERE activity_date BETWEEN ''2019-06-28'' AND ''2019-07-27''
        GROUP BY activity_date)';
    DBMS_OUTPUT.PUT_LINE('Test Case 3 (Single user with multiple activities on the same day):' || ' : ' || cnt);

    -- Test case 4: Multiple users with activities on different days
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 2, '2019-07-02', 'open_session');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 2, '2019-07-02', 'scroll_down');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 3, '2019-07-03', 'open_session');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 3, '2019-07-03', 'send_message');
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM (SELECT activity_date as day, COUNT(DISTINCT(user_id)) AS active_users
        FROM Activity
        WHERE activity_date BETWEEN ''2019-06-28'' AND ''2019-07-27''
        GROUP BY activity_date)';
    DBMS_OUTPUT.PUT_LINE('Test Case 4 (Multiple users with activities on different days):' || ' : ' || cnt);

    -- Test case 5: Multiple users with activities on the same day
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 2, '2019-07-01', 'open_session');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 2, '2019-07-01', 'scroll_down');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 3, '2019-07-01', 'open_session');
    INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 3, '2019-07-01', 'send_message');
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM (SELECT activity_date as day, COUNT(DISTINCT(user_id)) AS active_users
        FROM Activity
        WHERE activity_date BETWEEN ''2019-06-28'' AND ''2019-07-27''
        GROUP BY activity_date)';
    DBMS_OUTPUT.PUT_LINE('Test Case 5 (Multiple users with activities on the same day):' || ' : ' || cnt);
	
    COMMIT;
	
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/