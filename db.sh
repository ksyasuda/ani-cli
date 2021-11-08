#!/usr/bin/env bash

DIR="$XDG_CONFIG_HOME/ani-cli"
DB='history.sqlite3'

log() {
	printf "%s\n" "$1"
}

while getopts 'cdrqC' OPT; do
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
		C)
			log "Cleaning up database..."
			stmt="DELETE FROM search_history WHERE anime_name IS NULL or anime_name = ''"
			log "Cleaning up search history..."
			sqlite3 "$DIR/$DB" <<<"$stmt"
			stmt="DELETE FROM watch_history WHERE anime_name IS NULL or anime_name = ''"
			log "Cleaning up watch history..."
			sqlite3 "$DIR/$DB" <<<"$stmt"
			;;
		*)
			log "Does not exist or not implemented yet..."
			exit 1
			;;
	esac
done
