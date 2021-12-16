<div align="center">

![icon](https://imgur.com/HbyB4Cb.png)

# Aniwrapper

[**_Setup_**](#setup) | [**_Usage_**](#usage) | [**_Screenshots_**](#screenshots)

![Aniwrapper screenshot](https://imgur.com/QaftS71.png)

</div>

# Introduction

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

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

**Table of Contents**

- [Introduction](#introduction)
- [Setup](#setup)
  - [Dependencies](#dependencies)
    - [Skip Intro Script](#skip-intro-script)
  - [Installing](#installing)
    - [Arch Linux](#arch-linux)
    - [Manual Install](#manual-install)
    - [Install the Dependencies](#install-the-dependencies)
    - [Clone the repo](#clone-the-repo)
    - [Run setup script](#run-setup-script)
- [Aniwrapper Menus](#aniwrapper-menus)
  - [Search Anime](#search-anime)
  - [Anime Selection](#anime-selection)
  - [Episode Selection](#episode-selection)
- [Usage](#usage)
  - [aniwrapper](#aniwrapper)
    - [Option 1: Streaming](#option-1-streaming)
    - [Option 2: Download](#option-2-download)
    - [Option 3: Continue](#option-3-continue)
    - [Option 4: Playlist](#option-4-playlist)
    - [Option 5: Sync History](#option-5-sync-history)
  - [ani-cli Script](#ani-cli-script)
- [Screenshots](#screenshots)

<!-- markdown-toc end -->

# Setup

## Dependencies

These are the minimum dependences required to run `aniwrapper`

- grep
- curl
- sed
- mpv
- ffmpeg
- rofi
  - meh.rasi (installed in setup.sh)
- sqlite3

### Skip Intro Script

_This repo comes packaged with and will install the
[skip-intro.lua](https://github.com/rui-ddc/skip-intro)
script for MPV during setup if it is not already installed_

The script is activated with the `TAB` key

Upon activation, the skip-intro script will try its best to skip the
episode introduction by skipping to the next moment of silence in the video

- If the video has not pre-loaded past the introduction, the script will not
  know what to do. Press `TAB` again to stop the script until the video
  has loaded enough, or just manually skip past the intro.
- If the video does not have a pause in audio (or a significant enough drop in
  audio volume) between the end of the introduction and the beginning of the
  video/episode, then the script may fail and skip to a random point in the
  video

## Installing

### Arch Linux

`aniwrapper-git` is available on the AUR for Arch users

```sh
paru -S aniwrapper-git
or
yay -S aniwrapper-git
```

### Manual Install

To install manually, make sure the dependencies are installed first

### Install the Dependencies

```sh
# Arch
pacman -S --needed grep curl sed mpv ffmpeg rofi sqlite3

# Debian
apt install grep curl sed mpv ffmpeg rofi sqlite3
```

### Clone the repo

Use the following command to clone the Git repository locally and switch into the cloned directory

```sh
git clone https://github.com/ksyasuda/aniwrapper && cd aniwrapper
```

### Run the setup and install the script

After switching into the `aniwrapper` directory, run the following commands to set up and install the script

```sh
chmod +x setup.sh
./setup.sh && sudo make install
```

# Aniwrapper Menus

There are several menus used to drive the program forward

## Search Anime

The first menu consists of a search box and a list of anime titles corresponding to past valid searches. Choose an option from the menu, or enter in a unique search query to search for a new anime. The result from this will be used to query against `gogoanime` and return similar named anime

## Anime Selection

The next menu is where you select the anime to watch from a narrowed down list. Elements that have a blue border and text color indicate which anime have been watched before

- _In the future, I'd like to make it so if you select an option from the list of previously searched anime, then it will skip this and go on to episode selection_

## Episode Selection

In the episode selection menu, you can select an individual episode from the list, provide a single episode, or provide a range of episodes as two space separated integers `start_episode end_episode`. Like in the previous menu, any element with a blue border and text-color indicates that episode has been watched before

# Usage

## aniwrapper

    # Launch aniwrapper menu
    aniwrapper

### Option 1: Streaming

<div align="center">

[click here](https://imgur.com/nLjqLCL.gif) for an example showing streaming a new anime
[click here](https://imgur.com/nI455zI.gif) for an example showing streaming a previously watched anime

</div>

Streaming is the default option for the `aniwrapper` script and will prompt you with each of the menus specified in the _[aniwrapper Menus](#aniwrapper-menus)_ section

### Option 2: Download

The default download location is `$HOME/Videos/sauce` and will be chosen as the download directory unless otherwise specified

After specifying the download directory (or leaving it blank for the default), you will be presented with the menus from the _[aniwrapper Menus](#aniwrapper-menus)_ section for selecting the anime and episode(s) to download

### Option 3: Continue

The continue option queries the `sqlite3` history databse and pulls the list of distinct anime names from the `watch_history` table. Select an option from the list and the most recently watched episode of the selected anime will play

### Option 4: Playlist

_description coming soon_

### Option 5: Sync History

This option allows you to sync your search/watch history across devices. It queries the database on the remote machine and inserts/updates the necessary rows

At the moment, the requirements are as follows:

- You must be able to `ssh` into the remote machine
- The username must be the same across both devices
- The `history.sqlite3` file must be in the default location: `$XDG_CONFIG_HOME/aniwrapper/history.sqlite3`

## ani-cli Script

    # watch anime
    ani-cli <query>

    # download anime
    ani-cli -d <download_directory>

    # resume watching anime
    ani-cli -H

    # list searched anime
    ani-cli -l

    # playlist mode
    ani-cli -P

    # add to playlist
    ani-cli -a

    # sync history across devices
    ani-cli -s

Multiple episodes can be viewed/downloaded by giving the episode range like so

    Choose episode [1-13]: 1 6

This would open/download episodes 1 2 3 4 5 6

# Screenshots

<div align="center">

Aniwrapper Main Menu
![aniwrapper frontpage](https://imgur.com/QaftS71.png)
Aniwrapper Streaming Menu
![aniwrapper streaming options](https://imgur.com/jVJQERk.png)
More to come soon... maybe

</div>
