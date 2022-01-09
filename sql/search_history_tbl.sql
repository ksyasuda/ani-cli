CREATE TABLE IF NOT EXISTS search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0),
    UNIQUE (anime_name, search_date)
);

CREATE UNIQUE INDEX IF NOT EXISTS anime_search_idx ON search_history (anime_name, search_date);

