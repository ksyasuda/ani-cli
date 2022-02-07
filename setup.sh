#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
######################
# DO NOT RUN AS ROOT #
######################
VERBOSE=0

log() {
    if [[ "$VERBOSE" -eq 1 ]]; then
        printf "%s\n" "$*"
    fi
}

if [[ $# -ge 1 ]]; then
    if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
        VERBOSE=1
        log "VERBOSE LOGGING ENABLED"
    fi
fi

DB="history.sqlite3"

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/aniwrapper"
MPV_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"

log "CONFIG DIR:" "$DIR"
log "MPV DIR:" "$MPV_DIR"

# executes aniwrapper setup
# 1. create the aniwrapper directory in $XDG_CONFIG_HOME
# 2. create history databases in $DIR
# 3. move theme files to $DIR/themes/
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
        log "CREATING HISTORY DATABASE"
        sqlite3 "$DIR/$DB" < sql/search_history_tbl.sql
        sqlite3 "$DIR/$DB" < sql/watch_history_tbl.sql
        sqlite3 "$DIR/$DB" < sql/file_history.sql
        log "FINISHED CREATING DB"
    fi

    # log "themes directory does not exist in filesystem... Creating and moving themes"
    mkdir -p "$DIR/themes"
    cp themes/* "$DIR/themes/"
    log "Theme files moved..."

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
    cp .assets/icons/* "$DIR/icons/"
    log "Installed icons in config directory..."
}

if run_setup; then
    log "Setup Complete...."
else
    printf "%s\n" "There was an error during setup"
    exit 1
fi
