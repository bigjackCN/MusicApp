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
	ArtistName varchar(45) UNIQUE
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
	CONSTRAINT fk_artist FOREIGN KEY(ArtistID) REFERENCES artists(ArtistID),
	CONSTRAINT fk_album FOREIGN KEY(AlbumID) REFERENCES albums(AlbumID)
);

