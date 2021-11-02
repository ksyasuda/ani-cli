# ani-cli

This is a fork of [Dink4n's ani-cli](https://github.com/Dink4n/ani-cli),
which itself is a fork of
pystardust's [old-ani-cli](https://github.com/pystardust/ani-cli/tree/old-ani-cli)

This fork is a wrapper around a modified version of ani-cli
and uses [rofi](https://github.com/davatorium/rofi) to gather information and control the program

In addition to `rofi`, I've also changed the way saving history works by
integrating a local [sqlite3](https://www.sqlite.org/index.html) database with a table for
search and watch history

It is built around Dink4n's fork of ani-cli since at the time of
creation, this is the version that has downloading working correctly

This tool scrapes the site [gogoanime](https://gogoanime.vc).

It is intended to be called from the wrapper script `aniwrapper`,
however using the ani-cli script itself is also possible

## Usage

### Wrapper Script `aniwrapper`

    # Launch Menu (Contains same options as below, but in a rofi menu)
    aniwrapper

### ani-cli Script

    # watch anime
    ani-cli <query>

    # download anime
    ani-cli -d <download_directory>

    # resume watching anime
    ani-cli -H

    # list searched anime
    ani-cli -l

    # play a playlist :soon:
    ani-cli -p

Multiple episodes can be viewed/downloaded by giving the episode range like so

    Choose episode [1-13]: 1 - 6

This would open/download episodes 1 2 3 4 5 6

## Dependencies

- grep
- curl
- sed
- mpv
  - skip-intro.lua (installed in setup.sh)
- ffmpeg
- rofi
  - meh.rasi (installed in setup.sh)
- sqlite3
