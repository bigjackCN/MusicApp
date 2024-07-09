-- This is testing for our feature using production table

-- TEST FOR FUNCTION 6
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- Test1: successfully insert into users table
-- Since we are not having this user in our produciton table we are able to insert
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US301', 'test', 'test@gmail.com', 'test', 'test question', 'test answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test' OR Email='test@gmail.com');

-- Verify for test1
SELECT * FROM users WHERE UserID='US301';

-------------------------------------------------------------------------------------------


-- Test2: fail to insert due to email 'test@gmail.com' already exists
-- Notice we are using UQNIUE Email attribute
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US302', 'test2', 'test2@gmail.com', 'test2', 'test2 question', 'test2 answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test2' OR Email='test@gmail.com');

-- Verify for test2
SELECT * FROM users WHERE UserID='US302';
-------------------------------------------------------------------------------------------


-- Test3: fail to insert due to username 'test' already exists
-- Notice we are using UQNIUE UserName attribute
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US303', 'test3', 'test3@gmail.com', 'test3', 'test3 question', 'test3 answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test' OR Email='test3@gmail.com');

-- Verify for test3
SELECT * FROM users WHERE UserID='US303';


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



-- TEST FOR FUNCTION 8
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------