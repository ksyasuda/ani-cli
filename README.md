<div align="center">

# Aniwrapper

[**_Setup_**](#setup) | [**_Usage_**](#usage) | [**_Screenshots_**](#screenshots)

![Aniwrapper screenshot](https://imgur.com/HFq5gCq.png)

</div>

# Introduction

This is a fork of [Dink4n's ani-cli](https://github.com/Dink4n/ani-cli),
which itself is a fork of
pystardust's [old-ani-cli](https://github.com/pystardust/ani-cli/tree/old-ani-cli)

This fork is a wrapper around a modified version of ani-cli, which uses [rofi](https://github.com/davatorium/rofi)
to gather information and control the program flow.
In addition to `rofi`, I've also changed the way saving history works by
integrating a local [sqlite3](https://www.sqlite.org/index.html) database with a table for
search, watch, and file history

While this is a fork of a fork of pystardust's old-ani-cli, I would call this more of a light fork of the [the main ani-cli](https://github.com/pystardust/ani-cli).
I have implemented most of the main features from the original script and continue to use the same scraping logic

This tool scrapes the site [gogoanime](https://gogoanime.cm).

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

**Table of Contents**

-   [Introduction](#introduction)
-   [Setup](#setup)
    -   [Skip Intro Script](#skip-intro-script)
    -   [Installing](#installing)
        -   [Arch Linux](#arch-linux)
        -   [Manual Install](#manual-install)
            -   [Run the setup and install the script](#run-the-setup-and-install-the-script)
-   [Aniwrapper Menus](#aniwrapper-menus)
    -   [Search Anime](#search-anime)
        -   [Dealing with conflicting search queries / rofi grabbing from search list](#dealing-with-conflicting-search-queries--rofi-grabbing-from-search-list)
    -   [Anime Selection](#anime-selection)
    -   [Episode Selection](#episode-selection)
-   [Usage](#usage)
    -   [aniwrapper](#aniwrapper-1)
        -   [Option 1: Streaming](#option-1-streaming)
        -   [Option 2: Download](#option-2-download)
        -   [Option 3: Continue](#option-3-continue)
        -   [Option 4: Play from File](#option-4-play-from-file)
        -   [Option 5: Sync History](#option-5-sync-history)
        -   [Option 6: Choose Theme](#option-6-choose-theme)
    -   [ani-cli](#ani-cli)
-   [Screenshots](#screenshots)

<!-- markdown-toc end -->

# Setup

These are the minimum dependences required to run `aniwrapper`

```
aria2 curl grep mpv rofi sed sqlite3
```

## Skip Intro Script

_This repo comes packaged with and will install the
[skip-intro.lua](https://github.com/rui-ddc/skip-intro)
script for MPV during setup if it is not already installed_

**The script is activated with the `TAB` key**

Upon activation, the skip-intro script will try its best to skip the
episode introduction by skipping to the next moment of silence in the video

-   If the video has not pre-loaded past the introduction, the script will not
    know what to do. Press `TAB` again to stop the script until the video
    has loaded enough, or just manually skip past the intro.
-   If the video does not have a pause in audio (or a significant enough drop in
    audio volume) between the end of the introduction and the beginning of the
    video/episode, then the script may fail and skip to a random point in the
    video

## Installing

### Arch Linux

`aniwrapper-git` is available on the [AUR](https://aur.archlinux.org/packages/aniwrapper-git/) for Arch users

```sh
paru -S aniwrapper-git
or
yay -S aniwrapper-git
```

### Manual Install

Install the Dependencies

```sh
# Arch
pacman -S --needed aria2 curl grep mpv rofi sed sqlite3

# Debian
apt install aria2 curl grep mpv rofi sed sqlite3
```

Clone and switch into the repo directory

```sh
git clone https://github.com/ksyasuda/aniwrapper && cd aniwrapper
```

#### Run the setup and install the script

From the `aniwrapper` directory, run the following commands to set up and install the script

```sh
chmod +x setup.sh
./setup.sh && sudo make install
```

# Aniwrapper Menus

There are several menus used to drive the program forward

## Search Anime

The first menu consists of a search box and a list of anime titles corresponding to past valid searches. Choose an option from the menu, or enter in a unique search query to search for a new anime. The result from this will be used to query against `gogoanime` and return similar named anime

If selecting an anime from the provided list, the [anime selection](#anime-selection) menu will be skipped and the program will move on to [episode selection](#episode-selection) for the chosen anime

### Dealing with conflicting search queries / rofi grabbing from search list

In this program, rofi is configured to search with case insensitivity and select the best match from the list if there are matches. This can make it difficult at times to write a search query that does not trigger a selection from the rofi menu

<div align="center">

![selection with query 'isekai'](https://imgur.com/c2U4kdn.png)
Once your history starts filling up, it becomes progressively more difficult to form unique search queries

![selection with dash](https://imgur.com/vSyaoG6.png)
The workaround for this is to append a dash ` -` to the end of the search query<br/>
The above output was produced by searching: `isekai -`

</div>

## Anime Selection

The next menu is where you select the anime to watch from a narrowed down list of candidates. Titles that are highlighed in blue indicate that anime has been selected before

## Episode Selection

> Half-episodes (ex. saihate-no-paladin episode 7.5) are selectable, however they will not show up in the episodes list.
> To select half episodes add 'h' to the beginning for episodes like '7.5' -> 'h7' to select saihate-no-paladin episode 7.5

Here you will be prompted to select the episode(s) to watch/download

Multiple episodes can be downloaded by giving the episode range like so

```
Select Episode [1-13]: 1 6
```

This would open/download episodes 1 2 3 4 5 6

# Usage

## aniwrapper

```
# Launch menu (default video quality: best)
aniwrapper

# Launch menu with quality selection
aniwrapper -q

# Enable verbose logging
aniwrapper -v

# Connect to history database
aniwrapper -C

# Enable silent mode (suppress output to stdout) [cannot be used with -v]
aniwrapper -S

# Query the history database
aniwrapper -Q <query>

# Choose rofi theme from presets
aniwrapper -t <aniwrapper (default)|dracula|doomone|fancy|flamingo|material|nord|onedark>

# Specify custom rofi config
aniwrapper -T <path_to_config>

# Specify starting directory for play_from_file mode, bypassing main menu
aniwrapper -f <starting_directory>

# Use ani-cli command-line mode (rofi disabled)
aniwrapper -c

# Download anime in command-line mode
aniwrapper -d
```

### Option 1: Streaming

Streaming is the default option for the `aniwrapper` script and will prompt you with each of the menus specified in the _[aniwrapper Menus](#aniwrapper-menus)_ section

<details>

<summary>Example</summary>

<div align="center">

![example](https://imgur.com/wNoXjLX.gif)

</div>

</details>

### Option 2: Download

The default download location is `$HOME/Videos/sauce` and will be chosen as the download directory unless otherwise specified

After specifying the download directory (or leaving it blank for the default), you will be presented with the menus from the _[aniwrapper Menus](#aniwrapper-menus)_ section for selecting the anime and episode(s) to download

### Option 3: Continue

The continue option queries the `sqlite3` history databse and pulls the list of distinct anime names from the `watch_history` table. Select an option from the list and the most recently watched episode of the selected anime will play

### Option 4: Play from File

This option prompts you to provide the path to your `Videos` directory. Any path can be provided, but the script will begin the search from the provided path. From there, follow the prompts to select the video you want to watch and it will be opened in `mpv`

<details>

<summary>Example</summary>

<div align="center">

![example](https://imgur.com/ODB3lBu.gif)

</div>

</details>

### Option 5: Sync History

This option allows you to sync your search/watch history across devices. It queries the database on the remote machine and inserts/updates the necessary rows

At the moment, the requirements are as follows:

-   You must be able to `ssh` into the remote machine
-   The username must be the same across both devices
-   The `history.sqlite3` file must be in the default location: `$XDG_CONFIG_HOME/aniwrapper/history.sqlite3`

### Option 6: Choose Theme

Allows for changing the aniwrapper theme from the main menu

<details>

<summary>Example</summary>

<div align="center">

![example](https://imgur.com/o97YqLe.gif)

</div>

</details>

## ani-cli

```
# watch anime
ani-cli <query>

# verbose logging
ani-cli -v

# download anime
ani-cli -d <download_directory>

# resume watching anime
ani-cli -H

# sync history across devices
ani-cli -s

# choose quality
ani-cli -q <best (default)|1080p|720p|480p|360p|worst>

# choose rofi theme from presets
ani-cli -t <aniwrapper (default)|dracula|fancy|flamingo|material|nord|onedark>

# Specify starting directory for play_from_file mode (does not work with -c)
ani-cli -f <starting_directory>

# run ani-cli in command-line mode (rofi disabled)
ani-cli -c
```

# Screenshots

<div align="center">

Main Menu (default theme)

![aniwrapper main menu](https://imgur.com/HFq5gCq.png)

|                                                                                           |                                                                                                                |
| :---------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------: |
| <details><summary>doom-one</summary> ![doomone](https://imgur.com/zMU0i8l.png) </details> |            <details><summary>dracula</summary> ![dracula](https://imgur.com/BPdIuX3.png)</details>             |
|    <details><summary>fancy</summary>![fancy](https://imgur.com/CZx73NL.png)</details>     |            <details><summary>material</summary>![material](https://imgur.com/eTWkxw2.png)</details>            |
|  <details><summary>onedark</summary>![onedark](https://imgur.com/rchqtBm.png)</details>   | <details><summary>flamingo (sidebar theme)</summary>![flamingo-theme](https://imgur.com/pxF7hRE.png)</details> |

</div>
