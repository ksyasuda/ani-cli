#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
# DO NOT RUN AS ROOT

log() {
    printf "%s\n" "$1"
}

# DIR="$HOME/.ani-cli/"
DB="history.sqlite3"
DIR="$XDG_CONFIG_HOME/ani-cli/"
MPV_DIR="$XDG_CONFIG_HOME/mpv/"

[[ -z "$XDG_CONFIG_HOME" ]] && DIR="$HOME/.ani-cli"
[[ -z "$XDG_CONFIG_HOME" ]] && MPV_DIR="$HOME/.config/.ani-cli"

printf "%s\n" "INSTALL DIR: $DIR"

if [[ "$DIR" == "$HOME/.config" ]]; then
    printf "%s\n" "Maybe don't wanna delete that directory"
    exit 1
fi

log "Deleting old directory..."
rm -rf "$DIR"
log "Directory deleted..."

log "Creating directory $DIR"
mkdir -p "$DIR"
log "Directory created"

log "Creating history database..."
sqlite3 "$DIR"/"$DB" <sql/watch_history_tbl.sql
sqlite3 "$DIR"/"$DB" <sql/search_history_tbl.sql
log "History database created..."

log "Moving theme files..."
cp themes/meh.rasi "$DIR"/
cp themes/arc_dark_transparent_colors.rasi "$DIR"/
log "Theme files moved..."

log "Creating mpv/scripts/ directory if it doesn't exist..."
mkdir -p "$MPV_DIR/scripts/"
log "Created mpv scripts directory..."
log "Moving skip-intro.lua into mpv scripts directory..."
cp skip-intro.lua "$MPV_DIR/scripts/skip-intro.lua"
log "Moved skip-intro.lua into scripts directory..."

log "Setup Complete...."
