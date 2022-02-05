# Search Anime

<div align="center">

![search anime menu](https://imgur.com/i5uJIug.png)

</div>

The first menu consists of a search box and a list of anime titles corresponding to past valid searches. Choose an option from the menu, or enter in a unique search query to search for a new anime. The result from this will be used to query against `gogoanime` and return similar named anime

If selecting an anime from the provided list, the [anime selection](#anime-selection) menu will be skipped and the program will move on to [episode selection](#episode-selection) for the chosen anime

# Anime Selection

<div align="center">

![select anime menu](https://imgur.com/HIWAg6d.png)

</div>

The next menu is where you select the anime to watch from a narrowed down list of candidates. Titles that are highlighed in blue indicate that anime has been selected before

# Episode Selection

<div align="center">

![episode selection menu](https://imgur.com/bI4pz5V.png)

</div>

> Half-episodes (ex. saihate-no-paladin episode 7.5) are selectable, however they will not show up in the episodes list.
> To select half episodes add 'h' to the beginning for episodes like '7.5' -> 'h7' to select saihate-no-paladin episode 7.5

Here you will be prompted to select the episode(s) to watch/download

Multiple episodes can be downloaded by giving the episode range like so

```
Select Episode [1-13]: 1 6
```

This would open/download episodes 1 2 3 4 5 6

# Play from File

<div align="center">

![play from file 1](https://imgur.com/Xkrdi7a.png)
![play from file 2](https://imgur.com/i5uJIug.png)

</div>

In this option, you provide the program with a path, and it will begin searching the directory for subfolders or playable media in the current directory. Once a file is found, it will be opened in `mpv`

# Choose Theme

<div align="center">

![choose theme menu](https://imgur.com/btHUxUl.png)

</div>

Choose the `rofi` theme to use from the presets. Theme selection will persist through the duration of the program
