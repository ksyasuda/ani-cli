#!/usr/bin/env bash

DB='history.sqlite3'

while getopts 'cdr' OPT; do
	case "$OPT" in
	c)
		printf "%s\n" "Creating database..."
		sqlite3 "$DB" <sql/anime_search_history.sql
		sqlite3 "$DB" <sql/watch_history.sql
		printf "%s\n" "Created database..."
		;;
	d)
		printf "%s\n" "Deleting database..."
		rm -rf "$DB"
		printf "%s\n" "Database deleted..."
		;;

	r)
		printf "%s\n" "Deleting database..."
		rm -rf "$DB"
		printf "%s\n" "Database deleted..."
		printf "%s\n" "Creating database..."
		sqlite3 "$DB" <sql/anime_search_history.sql
		sqlite3 "$DB" <sql/watch_history.sql
		printf "%s\n" "Created database..."
		;;
	*)
		printf "%s\n" "Don't get here"
		exit 1
		;;
	esac
done
