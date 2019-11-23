#!/usr/bin/env bash

spotify="/usr/local/bin/spotify"

main () {
    if command -v $spotify &>/dev/null; then
        if [[ $(osascript -e 'application "Spotify" is running') == "true" ]]; then
            echo "$($spotify status track) - $($spotify status artist)"
        else
            echo "spotify = ded"
        fi
    else
        echo "hack the planet"
    fi
}

main
