-- This is test sample file using sample datasheet

-- Test1: all the users in our users table
-- We will see all the users from sample data
SELECT * FROM users;

-- Test2: all the English songs in our tracks table
-- we will see all the tracks with language attribute to be 'English' for sample data
SELECT TrackTitle, TrackLanguage FROM tracks WHERE TrackLanguage='English';

-- Test3: all the Spanish songs in our tracks table
-- we will see all the tracks with language attribute to be 'Spanish' for sample data
SELECT TrackTitle, TrackLanguage FROM tracks WHERE TrackLanguage='Spanish';

-- Test4: all the albums with Genre pop
-- we will see all the albums with pop Genre
SELECT AlbumTitle, ReleaseDate, Genre FROM albums WHERE Genre='pop';

-- Test5: all the albums with Genre rap
-- we will see all the albums with rap Genre
SELECT AlbumTitle, ReleaseDate, Genre FROM albums WHERE Genre='rap';

-- Test6: all the albums with Genre r&b
-- we will see all the albums with r&b Genre
SELECT AlbumTitle, ReleaseDate, Genre FROM albums WHERE Genre='r&b';

-- Test7: all the tracks by artist 'Billie Eilish'
-- we will see all the tracks made by the corresponding artist
SELECT TrackTitle FROM tracks WHERE ArtistID=(SELECT ArtistID FROM artists WHERE ArtistName='Billie Eilish');

-- Test8: all the albums by artist 'Billie Eilish'
-- we will see all the albums made by the corresponding artist
SELECT AlbumTitle, ReleaseDate, Genre FROM albums WHERE ArtistID=(SELECT ArtistID FROM artists WHERE ArtistName='Billie Eilish');

-- Test9: all the Playlist made by user "PL001"
SELECT Name FROM playlists WHERE UserID='US001';