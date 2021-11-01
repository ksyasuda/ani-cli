#!/usr/bin/env bash

DIR="$XDG_CONFIG_HOME/ani-cli"
DB='history.sqlite3'

log() {
	printf "%s\n" "$1"
}

while getopts 'cdrq' OPT; do
	case "$OPT" in
	c)
		log "Creating database..."
		sqlite3 "$DIR"/"$DB" <sql/search_history_tbl.sql
		sqlite3 "$DIR"/"$DB" <sql/watch_history_tbl.sql
		log "Created database..."
		;;
	d)
		log "Deleting database..."
		echo "$DIR/$DB"
		rm "$DIR/$DB"
		log "Database deleted..."
		;;

	r)
		log "Deleting database..."
		rm -rf "$DIR"/"$DB"
		mkdir -p "$DIR"
		log "Database deleted..."
		log "Creating database..."
		sqlite3 "$DIR"/"$DB" <sql/search_history_tbl.sql
		sqlite3 "$DIR"/"$DB" <sql/watch_history_tbl.sql
		log "Created database..."
		;;
	q)
		log "Connecting to database..."
		sqlite3 "$DIR/$DB"
		log "Ending connection to databse..."
		;;
	*)
		log "Don't get here"
		exit 1
		;;
	esac
done
