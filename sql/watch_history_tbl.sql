DROP TABLE IF EXISTS temp_watch_history;
CREATE TABLE temp_watch_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    anime_name VARCHAR(200) NOT NULL,
    episode_number INTEGER NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK(LENGTH(anime_name) > 0),
    CHECK(episode_number > 0),
    UNIQUE(anime_name, episode_number, watch_date)
);

CREATE TABLE IF NOT EXISTS watch_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    anime_name VARCHAR(200) NOT NULL,
    episode_number INTEGER NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK(LENGTH(anime_name) > 0),
    CHECK(episode_number > 0),
    UNIQUE(anime_name, episode_number, watch_date)
);

INSERT OR IGNORE INTO temp_watch_history
SELECT * FROM watch_history;

DROP TABLE watch_history;

CREATE TABLE watch_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    anime_name VARCHAR(200) NOT NULL,
    episode_number INTEGER NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK(LENGTH(anime_name) > 0),
    CHECK(episode_number > 0),
    UNIQUE(anime_name, episode_number, watch_date)
);
CREATE UNIQUE INDEX IF NOT EXISTS watch_anime_episode_idx ON watch_history(anime_name, episode_number);

INSERT INTO watch_history
SELECT * FROM temp_watch_history;

DROP TABLE IF EXISTS temp_watch_history;
