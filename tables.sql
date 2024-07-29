-- tables need to generating

-- Users Table
CREATE TABLE users(
	UserID varchar(45) PRIMARY KEY,
	UserName varchar(45) UNIQUE,
	Email varchar(45) UNIQUE,
    UserPassword varchar(45),
	SecurityQuestion varchar(100),
	SecurityAnswer varchar(45)
);

-- Artists Table
CREATE TABLE artists(
	ArtistID varchar(45) PRIMARY KEY,
	ArtistName varchar(45)
);

-- Albums Table
CREATE TABLE albums(
	AlbumID varchar(45) PRIMARY KEY,
	AlbumTitle varchar(100),
	ReleaseDate varchar(45),
	ArtistID varchar(45),
	Genre varchar(45),
	Rating varchar(45),
	CONSTRAINT fk_artist FOREIGN KEY(ArtistID) REFERENCES artists(ArtistID)
);

-- Tracks Table
CREATE TABLE tracks(
	TrackID varchar(45) PRIMARY KEY,
	TrackTitle varchar(100),
	ArtistID varchar(45),
	AlbumID varchar(45),
	Duration varchar(45),
	TrackLanguage varchar(45),
	Rating varchar(45),
	Genre varchar(45),
	CONSTRAINT fk_artist FOREIGN KEY(ArtistID) REFERENCES artists(ArtistID),
	CONSTRAINT fk_album FOREIGN KEY(AlbumID) REFERENCES albums(AlbumID)
);

-- Playlist Table
CREATE TABLE playlists(
	PlaylistID varchar(45) PRIMARY KEY,
	UserID varchar(45),
	Name varchar(100),
	CONSTRAINT fk_user FOREIGN KEY(UserID) REFERENCES users(UserID)
);

-- PlaylistTracks Table
CREATE TABLE playlistTracks(
	PlaylistTrackID varchar(45) PRIMARY KEY,
	PlaylistID varchar(45),
	TrackID varchar(45),
	CONSTRAINT fk_playlist FOREIGN KEY(PlaylistID) REFERENCES playlists(PlaylistID),
	CONSTRAINT fk_track FOREIGN KEY(TrackID) REFERENCES tracks(TrackID)
);

-----------------------------------------------------------------------------------------------------
-- After Import data sheet into database
-----------------------------------------------------------------------------------------------------


-- TrackSearch Table Created to match the Artist by Album
CREATE TABLE TrackSearch AS 
(SELECT tracks.TrackTitle, artists.ArtistName, albums.AlbumTitle, albums.ReleaseDate, albums.Genre FROM tracks 
JOIN artists ON artists.ArtistID=tracks.ArtistID
JOIN albums ON albums.AlbumID=tracks.AlbumID);



-- UserGallery Table Created to search through the tracks within playlist
CREATE TABLE UserGallery AS
(SELECT tracks.TrackTitle, playlists.Name, users.UserName FROM tracks
JOIN playlistTracks ON playlistTracks.TrackID = tracks.TrackID
JOIN playlists ON playlistTracks.PlaylistID = playlists.PlaylistID
JOIN users ON playlists.UserID = users.UserID);