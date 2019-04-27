#!/bin/bash

get_space () {
    if ! /usr/local/bin/chunkc tiling::query --desktop id 2>/dev/null; then
        if ! /usr/local/bin/kwmc query space active id 2>/dev/null; then
            echo 1
        fi
    fi
}

get_colors () {
    local WALC="$HOME/.cache/wal"
    local FN="colors_$1.sh"

    # attempt our space's colors
    local F="${WALC}/${FN}"
    if [[ -e $F ]]; then
        source $F
        echo "${background}:::${color1}"
        return 0
    fi
    
    # attempt space 1 colors
    local F="${WALC}/colors_1.sh"
    if [[ -e $F ]]; then
        source $F
        echo "${background}:::${color1}"
        return 0
    fi

    # fallback to non-cached colors
    local F="${WALC}/colors.sh"
    if [[ -e $F ]]; then
        source $F
        echo "${background}:::${color1}"
        return 0
    fi
}

main () {
    local space=$(get_space)
    local cols=$(get_colors $space)

    echo "${space}:::${cols}"
}

main
