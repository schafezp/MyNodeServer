CREATE DOMAIN username VARCHAR(16) NOT NULL;
CREATE DOMAIN title VARCHAR(64) NOT NULL;
CREATE DOMAIN fullpath TEXT NOT NULL;

CREATE TYPE permissionLevel AS ENUM('r', 'w', 'rw');
CREATE TYPE userLevel as ENUM('Admin', 'Mod', 'User');
--CREATE TYPE path must be implemented

------------ Create Tables ------------
CREATE TABLE UserAccount(
	Username username CHECK(LENGTH(Username) > 1),
	Password TEXT CHECK(LENGTH(Password) > 7),
	Salt TEXT NOT NULL,
	UserLevel userLevel NOT NULL,
	LastAccessDate TIMESTAMP NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	PRIMARY KEY(Username)
);

CREATE TABLE Friends(
	Username1 username NOT NULL,
	Username2 username NOT NULL,
	PRIMARY KEY(Username1, Username2),
	FOREIGN KEY(Username1) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(Username2) REFERENCES UserAccount(Username) ON DELETE CASCADE
);

CREATE TABLE Directory(
	DPath fullpath NOT NULL,
	ParentPath fullpath,
	Username username,
	PRIMARY KEY(DPath),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE
);

CREATE TABLE UserPermitsDirectory(
	Username username NOT NULL,
	DPath fullpath NOT NULL,
	PermissionLevel permissionLevel NOT NULL,
	PRIMARY KEY(Username, DPath),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(DPath) REFERENCES Directory(DPath)
);

CREATE TABLE File(
	FPath fullpath NOT NULL,
	ParentPath fullpath,
	Username username NOT NULL,
	PRIMARY KEY(FPath),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE
);

CREATE TABLE UserPermitsFile(
	Username username NOT NULL,
	FPath fullpath NOT NULL,
	PermissionLevel permissionLevel NOT NULL,
	PRIMARY KEY(Username, FPath),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(FPath) REFERENCES File(FPath)
);

------ Forum Tables ------
CREATE TABLE Category(
	Title title NOT NULL,
	Username username NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	LogoPath TEXT,
	PRIMARY KEY(Title),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE
);

CREATE TABLE Thread(
	Title title NOT NULL,
	Username username NOT NULL,
	CTitle title NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	PRIMARY KEY(Title),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(CTitle) REFERENCES Category(Title)
);

CREATE TABLE ThreadComment(
	Username username NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	TTitle title NOT NULL,
	Text text NOT NULL CHECK(LENGTH(text) > 0),
	PRIMARY KEY(Username, TimeOfCreation),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(TTitle) REFERENCES Thread(Title)
);

CREATE TABLE DirectoryComment(
	Username username NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	DPath fullpath NOT NULL,
	Text text NOT NULL CHECK(LENGTH(text) > 0),
	PRIMARY KEY(Username, TimeOfCreation),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(DPath) REFERENCES Directory(DPath)
);

CREATE TABLE FileComment(
	Username username NOT NULL,
	TimeOfCreation TIMESTAMP NOT NULL,
	FPath fullpath NOT NULL,
	Text text NOT NULL CHECK(LENGTH(text) > 0),
	PRIMARY KEY(Username, TimeOfCreation),
	FOREIGN KEY(Username) REFERENCES UserAccount(Username) ON DELETE CASCADE,
	FOREIGN KEY(FPath) REFERENCES File(FPath)
);
