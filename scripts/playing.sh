#!/usr/bin/env bash

spotify="/usr/local/bin/spotify"

main () {
    if command -v $spotify &>/dev/null; then
        if [[ $(osascript -e 'application "Spotify" is running') == "true" ]]; then
            track="$($spotify status track 2>/dev/null)"
            artist="$($spotify status artist 2>/dev/null)"
            if [[ -z "$track" ]]; then
                echo "spotify = paused"
            else
                echo "$track - $artist"
            fi
        else
            echo "spotify = ded"
        fi
    else
        echo "hack the planet"
    fi
}

main
