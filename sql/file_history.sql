DROP TABLE IF EXISTS temp_file_history;

CREATE TABLE IF NOT EXISTS temp_file_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    directory varchar(200) NOT NULL,
    filename varchar(200) NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(directory) > 0),
    CHECK (LENGTH(filename) > 0),
    UNIQUE (directory, filename)
);

-- make sure table has been set up at least once
CREATE TABLE IF NOT EXISTS file_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    directory varchar(200) NOT NULL,
    filename varchar(200) NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(directory) > 0),
    CHECK (LENGTH(filename) > 0),
    UNIQUE (directory, filename)
);


INSERT OR IGNORE INTO temp_file_history
SELECT * FROM file_history;

DROP TABLE file_history;

CREATE TABLE file_history (
    id integer PRIMARY KEY AUTOINCREMENT,
    directory varchar(200) NOT NULL,
    filename varchar(200) NOT NULL,
    watch_date DATETIME NOT NULL,
    CHECK (LENGTH(directory) > 0),
    CHECK (LENGTH(filename) > 0),
    UNIQUE (directory, filename)
);
CREATE UNIQUE INDEX dir_filename_idx ON file_history(directory, filename);

INSERT INTO file_history
SELECT * FROM temp_file_history;

DROP TABLE temp_file_history;
