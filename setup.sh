#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
# DO NOT RUN AS ROOT

log () {
    printf "%s\n" "$1"
}

# DIR="$HOME/.ani-cli/"
DB="history.sqlite3"
DIR="$XDG_CONFIG_HOME/ani-cli/"

[[ -z "$XDG_CONFIG_HOME" ]] && DIR="$HOME/.ani-cli"

printf "%s\n" "INSTALL DIR: $DIR"

if [[ "$DIR" == "$HOME/.config" ]]; then
    printf "%s\n" "Maybe don't wanna delete that directory"
    exit 1
fi

log "Deleting old directory..."
# rm -rf "$DIR"
log "Directory deleted..."

log "Creating directory $DIR"
mkdir -p "$DIR"
log "Directory created"

log "Creating history database..."
sqlite3 "$DIR"/"$DB" < sql/watch_history_tbl.sql
sqlite3 "$DIR"/"$DB" < sql/search_history_tbl.sql
log "History database created..."

log "Moving theme files..."
cp themes/meh.rasi "$DIR"/
cp themes/arc_dark_transparent_colors.rasi "$DIR"/
log "Theme files moved..."

