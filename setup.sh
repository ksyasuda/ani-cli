#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
######################
# DO NOT RUN AS ROOT #
######################
VERBOSE=1

log() {
	if [[ "$VERBOSE" -eq 1 ]]; then
		printf "%s\n" "$*"
	fi
}

DB="history.sqlite3"

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/aniwrapper"
MPV_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"

log "CONFIG DIR:" "$DIR"
log "MPV DIR:" "$MPV_DIR"

# executes aniwrapper setup
# 1. create the aniwrapper directory in $XDG_CONFIG_HOME
# 2. create history databases in $DIR
# 3. move theme files to $DIR
# 4. move skip-intro.lua into mpv/scripts folder
# 5. move the aniwrapper icon to $XDG_CONFIG_HOME/aniwrapper/ directory
run_setup() {
	log "INSTALL DIR: $DIR"

	if [[ ! -d "$DIR" ]]; then
		log "Creating directory $DIR"
		mkdir -p "$DIR"
		log "Directory created"
	fi

	if [[ ! -f "$DIR/$DB" ]]; then
		# Create the DB if not exists
		log "Creating history database..."
		sqlite3 "$DIR/$DB" sql/watch_history_tbl.sql
		sqlite3 "$DIR/$DB" sql/search_history_tbl.sql
		log "History database created..."
	fi

	if [[ ! -f "$DIR/aniwrapper.rasi" ]]; then
		# Move theme files and skip-intro script to correct locations
		log "aniwrapper.rasi does not exist in filesystem...  Moving theme files"
		cp themes/* "$DIR"/
		log "Theme files moved..."
	elif diff -q "themes/aniwrapper.rasi" "$DIR/aniwrapper.rasi" &>/dev/null; then
		log "Theme file has not changed... skipping"
	else
		log "Theme has changed... backing up old theme"
		mv "$DIR/aniwrapper.rasi" "$DIR/aniwrapper.rasi.bak"
		log "Renamed $DIR/aniwrapper.rasi -> $DIR/aniwrapper.rasi.bak"
		cp themes/aniwrapper.rasi "$DIR/"
	fi

	log "Creating mpv/scripts/ directory if it doesn't exist..."
	mkdir -p "$MPV_DIR/scripts/"
	if [[ ! -f "$MPV_DIR/scripts/skip-intro.lua" ]]; then
		log "Moving skip-intro.lua into mpv scripts directory..."
		cp lua/skip-intro.lua "$MPV_DIR/scripts/"
		log "Moved skip-intro.lua into scripts directory..."
	else
		log "skip-intro.lua already exists in $XDG_CONFIG_HOME/mpv/scripts/... skipping"
	fi

	if [[ ! -d "$DIR/icons" ]]; then
		log "Creating icons directory"
		mkdir -p "$DIR/icons"
	fi
	# install aniwrapper icons
	cp .assets/icons/* "$DIR/icons/"
	log "Installed icons in config directory..."
}

if run_setup; then
	log "Setup Complete...."
else
	printf "%s\n" "There was an error during setup"
	exit 1
fi
