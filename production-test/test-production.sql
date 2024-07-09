-- This is testing for our feature using production table

-- TEST FOR FUNCTION 1
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- Test1: successfully insert into users table
-- Since we are not having this user in our produciton table we are able to insert
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US301', 'test', 'test@gmail.com', 'test', 'test question', 'test answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test' OR Email='test@gmail.com');

-------------------------------------------------------------------------------------------

-- Test2: fail to insert due to email 'test@gmail.com' already exists
-- Notice we are using UQNIUE Email attribute
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US302', 'test2', 'test2@gmail.com', 'test2', 'test2 question', 'test2 answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test2' OR Email='test@gmail.com');

-------------------------------------------------------------------------------------------

-- Test3: fail to insert due to username 'test' already exists
-- Notice we are using UQNIUE UserName attribute
INSERT INTO users (UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer)
SELECT 'US303', 'test3', 'test3@gmail.com', 'test3', 'test3 question', 'test3 answer'
WHERE
NOT EXISTS(SELECT * FROM users WHERE UserName='test' OR Email='test3@gmail.com');

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



-- TEST FOR FUNCTION 2
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Test4: successfully login into users page
-- Notice we just insert 'test' as User in our users table
SELECT UserPassword FROM users WHERE UserName='test';

-------------------------------------------------------------------------------------------

-- Test5: fail to login into users page
-- Notice we just insert 'test' as User in our users table
SELECT UserPassword FROM users WHERE UserName='test2';

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------




-- TEST FOR FUNCTION 3
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

'''
CREATE TABLE TrackSearch AS 
(SELECT TrackTitle, ArtistName, AlbumTitle FROM tracks 
JOIN artists ON artists.ArtistID=tracks.ArtistID
JOIN albums ON albums.AlbumID=tracks.AlbumID);
'''

-- Test6: successfully get the track information from search
-- Make sure you have TrackSearch table which can be find at table.sql
SELECT * FROM TrackSearch WHERE TrackTitle='I Can See';

-------------------------------------------------------------------------------------------

-- Test7: fail to find the track information from search
-- Make sure you have TrackSearch table which can be find at table.sql 
SELECT * FROM TrackSearch WHERE TrackTitle='This is not a possible track';

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


-- TEST FOR FUNCTION 4
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Test8: Rate the track and update with new rating
-- Notice the current rating for 'Body On My' is 1 in our production table
UPDATE tracks SET Rating = DIV((SELECT (SELECT Rating from tracks WHERE TrackTitle='Body On My') ::DECIMAL + 10), 2) WHERE TrackTitle='Body On My';

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


-- TEST FOR FUNCTION 5
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Test9: Select all the tracks that has Genre of 'latin'
-- We will expect 176 rows being selected
SELECT AlbumID, AlbumTitle, ReleaseDate, ArtistID, Rating FROM Albums WHERE Genre = 'latin';

-------------------------------------------------------------------------------------------

-- Test10: Select null tracks that has Genre of 'null'
-- We will expect 0 rows being selected
SELECT AlbumID, AlbumTitle, ReleaseDate, ArtistID, Rating FROM Albums WHERE Genre = 'null';


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- TEST FOR FUNCTION 6
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Test11: Select Top 10 trending track from our tracks table
-- We limit 10 since our production data sheet now has over 1000 tracks

SELECT Genre, AlbumID, AlbumTitle FROM Albums WHERE Rating = '10' GROUP BY Genre, AlbumID, AlbumTitle LIMIT 10;

-------------------------------------------------------------------------------------------

-- Test12: Select Top 10 rap track from our tracks table
-- We limit 10 since our production data sheet now has over 1000 tracks
SELECT Genre, AlbumID, AlbumTitle FROM Albums WHERE Rating = '10' AND Genre='rap' GROUP BY Genre, AlbumID, AlbumTitle LIMIT 10;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------