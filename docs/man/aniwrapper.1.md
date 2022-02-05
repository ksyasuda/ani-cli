---
title: ANIWRAPPER
section: 1
header: Man Page
footer: aniwrapper 1.0.0
date: February 4, 2022
---

# NAME

aniwrapper - A rofi wrapper around ani-cli: a command-line tool to browser, download, and stream anime

# SYNOPSIS

**aniwrapper** [-cdhvqS] [-t _theme_ | -T *config_path*]\
**aniwrapper** [-cvS] [-t *theme* | -T *config_path*] -f _path_to_directory_\
**aniwrapper** -Q _query_\
**aniwrapper** -C\

# DESCRIPTION

**aniwrapper** is a wrapper around a modified version of **ani-cli**, which uses
**rofi** to get user input and control the program flow, as well as a
a **sqlite3** database for tracking search/watch history.

# OPTIONS

**-c**
: Enable command-line mode (disable **rofi**)

**-C**
: Connect to the history database _$XDG_CONFIG_HOME/aniwrapper/history.sqlite3_

**-d**
: Enable downloading anime in command-line mode

**-f**
: Specify the starting search directory for "Play from File" mode

**-h**
: Display the help message

**-q**
: Enable quality selection

**-Q** _query_
: Run a query on the history databse

**-S**
: Enable silent mode (suppress all output) [cannot be used with **-v**]

**-t** _<aniwrapper (default)|dracula|doomone|fancy|flamingo|material|nord|onedark>_
: Choose theme from presets

**-T** _path_to_theme_
: Provide custom **rofi** theme

**-v**
: Verbose output

# EXAMPLES

**aniwrapper**
: Run with default options (rofi enabled, best video quality, default theme)

**aniwrapper -q**
: Run with quality selection enabled

**aniwrapper -vqt doomone**
: Run with quality selection menu and _doomone_ theme

**aniwrapper -cd**
: Download an anime in command-line mode (**rofi** disabled)

**aniwrapper -Q "SELECT \* FROM watch_history ORDER BY watch_date DESC LIMIT 10;"**
: Query history database for your 10 most recently watched anime

**aniwrapper -f /media/videos**
: Run in "Play from File" mode starting the search from the _/media/videos_ directory

# SEE ALSO

**rofi(1), rofi-theme(5), rofi-keys(5), sqlite3(1)**

# AUTHOR

Written by Kyle Yasuda <ksyasuda@umich.edu>

Original code based on pystardust's _ani-cli_ (https://github.com/pystardust/ani-cli)
