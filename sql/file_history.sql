CREATE TABLE IF NOT EXISTS file_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    directory varchar(200) NOT NULL,
    filename varchar(200) NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(directory) > 0),
    CHECK (LENGTH(filename) > 0),
    UNIQUE (directory, filename)
);

CREATE UNIQUE INDEX IF NOT EXISTS dir_filename_idx ON file_history (directory, filename);

