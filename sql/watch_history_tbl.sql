CREATE TABLE watch_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    episode_number integer NOT NULL,
    watch_date date
);

