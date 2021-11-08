<div align="center">

# Aniwrapper

[Setup](#setup) | [Usage](#usage) | [Screenshots](#screenshots)

![Aniwrapper screenshot](./screenshots/aniwrapper_home.png)

</div>

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

**Table of Contents**

- [Aniwrapper](#aniwrapper)
- [Setup](#setup)
  - [Dependencies](#dependencies)
    - [Arch Linux](#arch-linux)
  - [Usage](#usage)
    - [aniwrapper](#aniwrapper)
    - [ani-cli Script](#ani-cli-script)

<!-- markdown-toc end -->

# Setup

## Dependencies

These are the minimum dependences required to run `aniwrapper`

- grep
- curl
- sed
- mpv
  - skip-intro.lua (installed in setup.sh)
- ffmpeg
- rofi
  - meh.rasi (installed in setup.sh)
- sqlite3

### Arch Linux

```sh
pacman -S --needed grep curl sed mpv ffmpeg rofi sqlite3
```

## Installing

```sh
git clone https://github.com/ksyasuda/aniwrapper
cd aniwrapper
```

After cloning the repository

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

### aniwrapper

    # Launch aniwrapper menu
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

    # add to playlist
    ani-cli -a

    # delete from playlist
    ani-cli -d

    # playlist mode
    ani-cli -P

Multiple episodes can be viewed/downloaded by giving the episode range like so

    Choose episode [1-13]: 1 6

This would open/download episodes 1 2 3 4 5 6
