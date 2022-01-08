CREATE TABLE watch_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    episode_number integer NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    CHECK (episode_number > 0),
    UNIQUE (anime_name, episode_number, watch_date)
);

CREATE UNIQUE INDEX IF NOT EXISTS watch_anime_episode_idx ON watch_history (anime_name, episode_number);

