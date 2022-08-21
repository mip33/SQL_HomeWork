INSERT INTO artist(artist_name)
VALUES
('Queen'),
('Nirvana'),
('AC/DC'),
('Eminem'),
('Kanye West'),
('Michael Jackson'),
('Lady Gaga'),
('Scooter'),
('ABBA');


INSERT INTO genre(genre_name)
VALUES
('rock'),
('hip-hop'),
('pop'),
('rave'),
('disco');


INSERT INTO album(album_name,year)
VALUES
('Made in Heaven', 1995),
('Nevermind', 1991),
('Back in Black', 1980),
('The Eminem Show', 2002),
('Graduation', 2007),
('Thriller', 1982),
('The Fame', 2008),
('Wicked!', 1996),
('Arrival', 1976);

insert into track(track_name,duration,album_id)
values
('Made in Heaven', 326, 1),
('Let Me Live', 436, 1),
('Smells Like Teen Spirit', 366, 2),
('In Bloom', 308, 2),
('Hells Bells', 346, 3),
('Back in Black', 320, 3)
('Shoot to Thrill', 254, 3),
('White America', 324, 4),
('Business', 251, 4),
('Good Morning', 187, 5),
('Stronger', 312, 5),
('Thriller', 255, 6),
('Billie Jean', 284, 6),
('Just Dance', 190, 7),
('LoveGame', 200, 7),
('Life Is Love', 239, 8),
('Friends', 241, 9);

insert into album_artist(artist_id,album_id)
values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9);


insert into genre_artist(genre_id,artist_id)
values
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(3,6),
(3,7),
(4,8),
(5,9);

insert into collection(name,year)
values
('hip-hop dance',1998),
('rave gold',2000),
('legends rock',2005),
('hits 90', 1995),
('disco hits',2008),
('gold collection', 2010),
('best rock hit', 2015),
('mega hits', 2003),
('Grands hits', 2020);


insert into track_collection(collection_id,track_id)
values
(1,8),
(1,9),
(1,10),
(1,11),
(2,16),
(3,1),
(3,2),
(3,5),
(3,4),
(4,12),
(4,13),
(5,17),
(6,15),
(6,13),
(7,3),
(7,7),
(7,6),
(8,17),
(8,16),
(8,14)
(9,12),
(9,8),
(9,2);