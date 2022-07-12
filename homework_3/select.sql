-- название и год выхода альбомов, вышедших в 2018 году;
SELECT album_name , "year" FROM album
	WHERE "year" = 2007;

-- название и продолжительность самого длительного трека;
SELECT track_name ,duration FROM track
	WHERE duration = (
		SELECT max(duration)
		FROM track);

-- название треков, продолжительность которых не менее 3,5 минуты;
SELECT track_name  FROM track
	WHERE duration  > 210;

-- названия сборников, вышедших в период с 2018 по 2020 год включительно;
SELECT name FROM collection
	WHERE "year" BETWEEN 2010 AND 2020;

-- исполнители, чье имя состоит из 1 слова;
SELECT artist_name  FROM artist
	WHERE artist_name  NOT LIKE '% %';

-- название треков, которые содержат слово "мой"/"my"
SELECT track_name  FROM track
	where track_name ILIKE '%my%' OR track_name ILIKE '%мой%';