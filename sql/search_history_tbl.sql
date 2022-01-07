DROP TABLE IF EXISTS temp_search_history;

CREATE TABLE IF NOT EXISTS temp_search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    UNIQUE (anime_name, search_date)
);

CREATE TABLE IF NOT EXISTS search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    UNIQUE (anime_name, search_date)
);

INSERT OR IGNORE INTO temp_search_history
SELECT * FROM search_history;

DROP TABLE IF EXISTS search_history;

CREATE TABLE search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    UNIQUE (anime_name, search_date)
);

CREATE UNIQUE INDEX anime_search_idx ON search_history (anime_name, search_date);

INSERT INTO search_history
SELECT * FROM temp_search_history;

DROP TABLE temp_search_history;

