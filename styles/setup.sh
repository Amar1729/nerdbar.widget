#!/bin/bash

# use this file to create a symlink to your wal-generated css files for auto color loading.

if [[ ! -d $HOME/.cache/wal ]]; then
    printf "Color loading based on your wallpaper is powered by pywal.\n"
    printf "The css file expects a directory here:\n"
    printf "$HOME/.cache/wal\n"
    printf "And the .css files generated by wal. Please install and run it to continue.\n"
    exit 1
fi

if [[ -e $HOME/.cache/wal/colors.css ]]; then
    # this is the file i use:
    #ln -s $HOME/.cache/wal/colors_1.css ./colors-wal.css
    ln -s $HOME/.cache/wal/colors.css ./colors-wal.css || exit 0

    printf "Symlink: colors-wal.css created.\n"
fi
