---
title: ANIWRAPPER
section: 1
header: Man Page
footer: aniwrapper 1.0.0
date: February 4, 2022
---

# NAME

aniwrapper - A rofi wrapper around ani-cli: a command-line tool to stream, download, and play anime

# SYNOPSIS

**aniwrapper** [-adhpqrSv] [-t _theme_ | -T _config_path_] [_query_]\
**aniwrapper** -f _directory_path_ [-t _theme_ | -T _config_path_] [-pSv] [_query_]\
**aniwrapper** -c [-dhpqrSv] [_query_]\
**aniwrapper** -Q _query_\
**aniwrapper** -C

# DESCRIPTION

**aniwrapper** is a wrapper around a modified version of **ani-cli**, which uses
**rofi** to get user input and control the program flow, as well as a
a **sqlite3** database for tracking search/watch history

# OPTIONS

Defaults:

- **rofi** enabled
- aniwrapper.rasi theme
- best quality

**-a**
: Enable autoplay in streaming mode

**-c**
: Enable command-line mode (disable **rofi**)

**-C**
: Connect to the history database _$XDG_CONFIG_HOME/aniwrapper/history.sqlite3_

**-d**
: Enable downloading anime in command-line mode

**-e** _episode_ **or** _begin_episode - end_episode_
: Select episode(s) to stream/download

**-f**
: Specify the starting search directory for "Play from File" mode

**-h**
: Display the help message

**-p**
: Enable video player selection menu

**-P**
: Enable provider selection menu

**-q**
: Enable quality selection

**-r**
: Start script at episode selection for the most recently watched anime

**-Q** _query_
: Run a query on the history databse

**-S**
: Enable silent mode (suppress all output) [cannot be used with **-v**]

**-t** _alter|aniwrapper (default)|dracula|doomone|fancy|flamingo|material|monokai|nord|onedark_
: Choose theme from presets

**-T** _path_to_theme_
: Provide custom **rofi** theme

**-v**
: Verbose output

# EXAMPLES

**aniwrapper**
: Launch main menu with default options

**aniwrapper konosuba**
: Run in _stream_ mode with a _search query_ = "konosuba"

**aniwrapper -qd naruto**
: Run in _download_ mode with _quality selection enabled_ and a _search query_ =
"naruto"

**aniwrapper -vqt doomone**
: Run with _quality selection enabled_ and the _doomone_ theme

**aniwrapper -cqd**
: Run in _command-line_ _download_ mode with _quality selection enabled_ (**rofi** disabled)

**aniwrapper -Q "SELECT \* FROM watch_history ORDER BY watch_date DESC LIMIT 10;"**
: Query history database for your 10 most recently watched anime

**aniwrapper -f /media/videos -t dracula**
: Run in _Play from File_ mode, using the _dracula_ theme, and with the _search_ starting from _/media/videos_

**aniwrapper -S**
: Run in _silent_ mode (suppress all output to stdout and disable notifications)

# SEE ALSO

**rofi(1), rofi-theme(5), rofi-keys(5), sqlite3(1)**

# AUTHOR

Written by Kyle Yasuda <ksyasuda@umich.edu>

Original code based on pystardust's _ani-cli_ (<https://github.com/pystardust/ani-cli>)
