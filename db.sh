#!/usr/bin/env bash

[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"

DIR="$XDG_CONFIG_HOME/aniwrapper"
DB='history.sqlite3'

log() {
	printf "%s\n" "$1"
}

while getopts 'cdrqCs' OPT; do
	case "$OPT" in
		c)
			log "Creating database..."
			sqlite3 "$DIR"/"$DB" < sql/search_history_tbl.sql
			sqlite3 "$DIR"/"$DB" < sql/watch_history_tbl.sql
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
			sqlite3 "$DIR"/"$DB" < sql/search_history_tbl.sql
			sqlite3 "$DIR"/"$DB" < sql/watch_history_tbl.sql
			log "Created database..."
			;;
		q)
			log "Connecting to database..."
			sqlite3 "$DIR/$DB"
			log "Ending connection to databse..."
			;;
		C)
			log "Cleaning up database..."
			stmt="DELETE FROM search_history WHERE anime_name IS NULL OR anime_name = ''"
			log "Cleaning up search history..."
			sqlite3 "$DIR/$DB" <<< "$stmt"
			stmt="DELETE FROM watch_history WHERE anime_name IS NULL OR anime_name = '' OR episode_number = 0"
			log "Cleaning up watch history..."
			sqlite3 "$DIR/$DB" <<< "$stmt"
			;;
		s)
			printf "%s" "Enter connection string for remote user in the form user@host: "
			read -r connection_str
			printf "%s" "Enter port to connect to remote host with or leave blank for default (22): "
			read -r port
			if [[ ! "${port/ //}" == "" ]]; then
				PORT="$port"
			fi

			if [[ ! "@" != *"$connection_str" ]]; then
				log "Enter in full connection string to remote user in the form: user@host"
				exit 1
			fi

			log "Syncing database with: $connection_str on port $PORT"

			scp -P "$PORT" "$connection_str:$DIR/$DB" "$temp_db"
			if [[ "$?" -ne 0 ]]; then
				printf "%s\n" "Error getting database file from remote host"
				exit 1
			fi
			sync_search_history && sync_watch_history
			;;
		*)
			log "Does not exist or not implemented yet..."
			exit 1
			;;
	esac
done
