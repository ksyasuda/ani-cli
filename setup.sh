#!/usr/bin/env bash


log () {
    printf "%s\n" "$1"
}

DIR="$HOME/.ani-cli/"
DB="history.sqlite3"

log "Deleting old directory..."
rm -rf "$DIR"
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
