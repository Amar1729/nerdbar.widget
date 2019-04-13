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

    [[ -e "${WALC}/${FN}" ]] && source "${WALC}/${FN}" || source "${WALC}/colors.sh"

    echo "${background}:::${color1}"
}

main () {
    local space=$(get_space)
    local cols=$(get_colors $space)

    echo "${space}:::${cols}"
}

main
