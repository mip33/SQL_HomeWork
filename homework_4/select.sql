--1)количество исполнителей в каждом жанре;
select  g.genre_name  , COUNT(artist_id)
from genre_artist ga , genre g
where ga.genre_id = g.id
group by g.id ;

--2)все исполнители, которые не выпустили альбомы в 2019-2020 году
select artist_name,year
from album_artist aa
join album a on aa.album_id = a.id
join artist a2 on aa.artist_id=a2.id
group by artist_name, year
having year = 2019 or year = 2020

-- 3)Считаем среднее продолжительность треков по каждому альбому
select a.album_name ,  AVG(t.duration)
from track t, album a
where t.album_id = a.id
group by a.album_name;


-- 4)Считаем исполнителей без альбомов в 2020
select a.artist_name
from album_artist aa, artist a, album a2
where aa.artist_id = a.id  and not a2."year" = 2020
group by a.artist_name ;

-- 5)названия сборников в которых есть исполнитель "Nirvana"
select c."name", a.artist_name
from collection c, track_collection tc, track t, album_artist aa , artist a
where c.id = tc.collection_id and tc.track_id  = t.id and t.album_id = aa.album_id and aa.artist_id = a.id and a.id = 2


-- 6)названия альбомов в которых присутствуют исполнители более 1 жанра

select a.album_name album_name
from album a
join album_artist aa on a.id = aa.album_id
join genre_artist ga on aa.artist_id = ga.artist_id
group by a.album_name
having count(ga.artist_id) > 1

-- 7)найти названия треков, которые не входят в сборник
select t.track_name
from track t
where not exists (
		select tc.track_id
		from track_collection tc
		where tc.track_id = t.id)

-- 8)найти автора который написал самый короткий трек
select  a.artist_name
from artist a
join album_artist aa on a.id = aa.artist_id
join album a2 on a.id = aa.artist_id
join track t on t.album_id = a.id
where t.duration = (select min(duration) from track)

-- 9)альбомы с наименьшим количеством треков

select a.album_name album_name
from album a, track t
where t.album_id = a.id
group by album_name
having count(a.album_name) = (
				select min(quan)
				from (
						select count(t2.album_id) as quan
						from album a2, track t2
						where a2.id = t2.album_id
						group by a2.album_name
						)
				as foo
				)
