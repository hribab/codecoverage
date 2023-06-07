-- Test Code

-- Prepare the test environment
DROP TABLE IF EXISTS tree;

CREATE TABLE tree
(
    id   INT PRIMARY KEY,
    p_id INT
);

-- Test Case 1: Basic test with 5 nodes in the tree
INSERT INTO tree (id, p_id)
VALUES (1, NULL),
       (2, 1),
       (3, 1),
       (4, 2),
       (5, 2);

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 1 AND Type = 'Root';

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 2 AND Type = 'Inner';

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 3 AND Type = 'Leaf';

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 4 AND Type = 'Leaf';

-- Test Case 2: Test with a single node in the tree
TRUNCATE TABLE tree;

INSERT INTO tree (id, p_id)
VALUES (1, NULL);

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 1 AND Type = 'Root';

-- Test Case 3: Test with 2 nodes in the tree
TRUNCATE TABLE tree;

INSERT INTO tree (id, p_id)
VALUES (1, NULL),
       (2, 1);

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 1 AND Type = 'Root';

SELECT *
FROM
(
    SELECT id AS Id, CASE
          WHEN tree.id = (SELECT atree.id FROM tree atree WHERE atree.p_id IS NULL)
            THEN 'Root'
          WHEN tree.id IN (SELECT atree.p_id FROM tree atree)
            THEN 'Inner'
          ELSE 'Leaf'
        END AS Type
    FROM tree
    ORDER BY Id
) AS result
WHERE Id = 2 AND Type = 'Leaf';

-- Cleanup the test environment
DROP TABLE tree;
