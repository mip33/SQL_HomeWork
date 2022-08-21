
create table genre(
id serial primary key,
genre_name varchar(255)
);


create table artist(
id serial primary key,
artist_name varchar(255)
);


create table album(
id serial primary key,
album_name varchar(255),
year integer
);



create table genre_artist(
id serial primary key,
genre_id integer references genre(id),
artist_id integer  references artist(id));



create table album_artist(
id serial primary key,
artist_id integer references artist(id),
album_id integer references album(id));


create table track(
id serial primary key,
track_name varchar(255),
duration integer,
album_id integer references album(id));


create table collection(
id serial primary key,
name varchar(255),
year integer);

create table track_collection(
id serial primary key,
collection_id integer references collection(id),
track_id integer references track(id));