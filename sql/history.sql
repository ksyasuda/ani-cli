CREATE TABLE IF NOT EXISTS anime (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    anime_name VARCHAR(255) NOT NULL UNIQUE,
    start_episode INTEGER NOT NULL,
    end_episode INTEGER NOT NULL,
    data_date DATETIME NOT NULL,
    CHECK(start_episode <= end_episode),
    CHECK(LENGTH(anime_name) > 0)
);

CREATE TABLE IF NOT EXISTS file_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    directory varchar(200) NOT NULL,
    filename varchar(200) NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(directory) > 0),
    CHECK (LENGTH(filename) > 0),
    UNIQUE (directory, filename)
);

CREATE TABLE IF NOT EXISTS watch_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    episode_number integer NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    UNIQUE (anime_name, episode_number)
);

CREATE TABLE IF NOT EXISTS search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL UNIQUE,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0)
);

CREATE UNIQUE INDEX IF NOT EXISTS anime_search_idx ON search_history (anime_name);
CREATE UNIQUE INDEX IF NOT EXISTS watch_anime_episode_idx ON watch_history (anime_name, episode_number);
CREATE UNIQUE INDEX IF NOT EXISTS dir_filename_idx ON file_history (directory, filename);
