-- Unit test code

-- Test Case 1: Check if the test case returns the author_ids in ascending order
BEGIN
  INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
    (1, 1, 1, '2021-01-01'),
    (2, 2, 2, '2021-01-02'),
    (3, 3, 3, '2021-01-03'),
    (4, 1, 1, '2021-01-04');
  
  SELECT DISTINCT(author_id) AS id FROM Views WHERE author_id IN (viewer_id) ORDER BY author_id ASC;
  
  ROLLBACK;
END;

-- Test Case 2: Check if the test case returns no record if no author viewed their own article
BEGIN
  INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
    (1, 1, 2, '2021-01-01'),
    (2, 2, 3, '2021-01-02'),
    (3, 3, 1, '2021-01-03'),
    (4, 1, 3, '2021-01-04');
  
  SELECT DISTINCT(author_id) AS id FROM Views WHERE author_id IN (viewer_id) ORDER BY author_id ASC;
  
  ROLLBACK;
END;

-- Test Case 3: Check if the test case returns unique author_ids
BEGIN
  INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
    (1, 1, 1, '2021-01-01'),
    (2, 1, 1, '2021-01-02'),
    (3, 1, 1, '2021-01-03'),
    (4, 1, 1, '2021-01-04');
  
  SELECT DISTINCT(author_id) AS id FROM Views WHERE author_id IN (viewer_id) ORDER BY author_id ASC;
  
  ROLLBACK;
END;

-- Test Case 4: Check if the test case returns correct result with duplicate rows in the table
BEGIN
  INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
    (1, 1, 1, '2021-01-01'),
    (1, 1, 1, '2021-01-01'), -- Duplicate row
    (2, 2, 2, '2021-01-02'),
    (2, 2, 2, '2021-01-02'); -- Duplicate row
  
  SELECT DISTINCT(author_id) AS id FROM Views WHERE author_id IN (viewer_id) ORDER BY author_id ASC;
  
  ROLLBACK;
END;

-- Test Case 5: Check if the test case returns correct result with mixed data
BEGIN
  INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
    (1, 1, 1, '2021-01-01'),
    (2, 2, 2, '2021-01-02'),
    (3, 3, 1, '2021-01-03'),
    (4, 1, 3, '2021-01-04'),
    (5, 3, 3, '2021-01-05'),
    (6, 4, 4, '2021-01-06');
  
  SELECT DISTINCT(author_id) AS id FROM Views WHERE author_id IN (viewer_id) ORDER BY author_id ASC;
  
  ROLLBACK;
END;