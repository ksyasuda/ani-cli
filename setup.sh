#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
######################
# DO NOT RUN AS ROOT #
######################
VERBOSE=0

DB="history.sqlite3"

# Set the XDG_CONFIG_HOME locally if not set
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

DIR="$XDG_CONFIG_HOME/aniwrapper"
MPV_DIR="$XDG_CONFIG_HOME/mpv"

log() {
    if [[ "$VERBOSE" -eq 1 ]]; then
        printf "%s\n" "$*"
    fi
}

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

    if [[ ! -f "$DIR"/"$DB" ]]; then
        # Create the DB if not exists
        log "Creating history database..."
        sqlite3 "$DIR"/"$DB" <sql/watch_history_tbl.sql
        sqlite3 "$DIR"/"$DB" <sql/search_history_tbl.sql
        log "History database created..."
    fi

    # Move theme files and skip-intro script to correct locations
    log "Moving theme files..."
    cp themes/* "$DIR"/
    log "Theme files moved..."

    log "Creating mpv/scripts/ directory if it doesn't exist..."
    mkdir -p "$MPV_DIR/scripts/"
    log "Created mpv scripts directory..."
    if [[ ! -f "$MPV_DIR/scripts/skip-intro.lua" ]]; then
      log "Moving skip-intro.lua into mpv scripts directory..."
      cp lua/skip-intro.lua "$MPV_DIR/scripts/"
      log "Moved skip-intro.lua into scripts directory..."
    else
      log "skip-intro.lua already exists in $XDG_CONFIG_HOME/mpv/scripts/"
    fi

	# install aniwrapper icon
	# xdg-icon-resource install --size 64 ./assets/icons/icon-64.png aniwrapper --novendor
	cp .assets/icons/icon-64.png "$XDG_CONFIG_HOME/aniwrapper/icon-64.png"
}

if [[ ! -d "$DIR" ]]; then
    if run_setup; then
        log "Setup Complete...."
    else
        printf "%s\n" "There was an error during setup"
        exit 1
    fi
else
    log "Directory exists... skipping setup"
    exit 0
fi
