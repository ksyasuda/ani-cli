#!/usr/bin/env bash

# Setup script to move the rofi theme files to the correct location
# As well as set up the history database
######################
# DO NOT RUN AS ROOT #
######################
VERBOSE=0

lg() {
	if [[ "$VERBOSE" -eq 1 ]]; then
		printf "%s\n" "$*"
	fi
}

if [[ $# -ge 1 ]]; then
	if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
		VERBOSE=1
		lg "VERBOSE lgGING ENABLED"
	fi
fi

DB="history.sqlite3"

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/aniwrapper"
MPV_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mpv"

lg "CONFIG DIR:" "$DIR"
lg "MPV DIR:" "$MPV_DIR"

# executes aniwrapper setup
# 1. create the aniwrapper directory in $XDG_CONFIG_HOME
# 2. create history databases in $DIR
# 3. move theme files to $DIR/themes/
# 4. move skip-intro.lua into mpv/scripts folder
# 5. move the aniwrapper icon to $XDG_CONFIG_HOME/aniwrapper/ directory
run_setup() {
	lg "INSTALL DIR: $DIR"

	if [[ ! -d "$DIR" ]]; then
		lg "Creating directory $DIR"
		mkdir -p "$DIR"
		lg "Directory created"
	fi

	lg "CREATING HISTORY DATABASE IF NOT EXISTS"
	sqlite3 "$DIR/$DB" < sql/history.sql
	lg "FINISHED CREATING DB"

	lg "INSTALLING UI FILES TO $DIR/lib/ani-cli"
	mkdir -p "$DIR/lib/ani-cli"
	cp -r lib/ani-cli/* "$DIR/lib/ani-cli/"
	lg "FINISHED INSTALLING UI FILES"

	# lg "themes directory does not exist in filesystem... Creating and moving themes"
	mkdir -p "$DIR/themes"
	cp themes/* "$DIR/themes/"
	lg "Theme files moved..."

	lg "Creating mpv/scripts/ directory if it doesn't exist..."
	mkdir -p "$MPV_DIR/scripts/"
	if [[ ! -f "$MPV_DIR/scripts/skip-intro.lua" ]]; then
		lg "Moving skip-intro.lua into mpv scripts directory..."
		cp lua/skip-intro.lua "$MPV_DIR/scripts/"
		lg "Moved skip-intro.lua into scripts directory..."
	else
		lg "skip-intro.lua already exists in $XDG_CONFIG_HOME/mpv/scripts/... skipping"
	fi

	if [[ ! -d "$DIR/icons" ]]; then
		lg "Creating icons directory"
		mkdir -p "$DIR/icons"
	fi
	cp .assets/icons/* "$DIR/icons/"
	lg "Installed icons in config directory..."
}

if run_setup; then
	lg "Setup Complete...."
else
	printf "%s\n" "There was an error during setup"
	exit 1
fi
