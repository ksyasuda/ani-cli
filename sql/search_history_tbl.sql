CREATE TABLE search_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    anime_name varchar(200) NOT NULL UNIQUE,
    search_date DATETIME NOT NULL,
    CHECK (LENGTH(anime_name) > 0)
);

CREATE UNIQUE INDEX anime_search_idx ON search_history (anime_name, search_date);

