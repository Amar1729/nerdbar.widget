#!/bin/bash

# Attemps to return:
# LHS | MHS | RHS
# LHS: type of tiling on space
# MHS: number of spaces (e.g. 1 2 (3))
# RHS: name of focused window
#
# Tries chunkc first, falls back to kwmc

get_chunk() {
    chunkc=/usr/local/bin/chunkc

    # Test if chunkc is active/exists first
    # Exit if not running so spaces.sh can handle it
    if ! MODE=$($chunkc tiling::query -d mode)
    then
        return 1
    fi

    # LHS:
    # Get tiling mode + number of windows in monocle
    case $MODE in
        bsp)
            LHS="[bsp]"
            ;;
        float)
            LHS="[float]"
            ;;
        monocle)
            # list of windows (use for monocle)
            WINDOWS=$($chunkc tiling::query -d windows | /usr/bin/sed '/(invalid)/d')
            #WINDOWS=$($chunkc tiling::query -d windows)
            NUM_WIN=$(echo "$WINDOWS" | wc -l)
            LHS="[n /""$NUM_WIN""]"
            ;;
        *)
            LHS="[ ]"
            ;;
    esac

    # MHS:
    # Get list of spaces, and surround active space with ()
    # NOTE - this route is frackin' killing chunkwm so ... (?)
    #MONITOR="$($chunkc tiling::query -m id)"
    #SPACES="$($chunkc tiling::query --desktops-for-monitor $MONITOR)"
    #MHS=$(echo $SPACES | sed "s|\($($chunkc tiling::query -d id)\)|(\1)|")
    MHS="$($chunkc tiling::query -d id)"
    MHS="($MHS)"


    # RHS:
    # get name of focused window
    RHS=$($chunkc tiling::query -w tag)
    if [[ -z "$RHS" ]]; then RHS="~~"; fi

    echo "$LHS | $MHS | $RHS"
}

get_kwm() {
    kwmc=/usr/local/bin/kwmc

    # get active and previous space
    if ! active=$($kwmc query space active id)
    then
        return 1
    fi

    # get array of spaces
    spaces=()
    i=0
    while read -r line
    do
        spaces[i]="$line"
        (( i++ ))
    done <<< "$($kwmc query space list)"

    # populate bar with icons
    bar=()
    for (( i = 0; i < ${#spaces[@]}; i++ ))
    do
        if [[ ${spaces[$i]} == *"[no tag]" ]] #|| "$i" -lt 5 ]]
        then
            bar[$i]=$(($i+1))
        else
            if [[ "$i" == "9" ]]
            then
                id="${spaces[$i]:4}"
            else
                id="${spaces[$i]:3}"
            fi
            # bar[$i]="$(echo $id | tr '[:lower:]' '[:upper:]')"
            bar[$i]="$[$i+1]/$id"
        fi
    done

    # style active and previous space icons
    bbar=()
    for (( i = 0; i < ${#bar[@]}; i++ ))
    do
        if [[ $(($i+1)) == "$active" ]]
        then
            bbar[(($i*3+1))]="("${bar[$i]}")"
        else
            bbar[(($i*3+1))]=" ${bar[$i]} "
        fi
    done

    MODE="$($kwmc query space active mode)"
    SPACES="$(echo ${bbar[*]})"
    FOCUSED="$($kwmc query window focused name)"

    echo "$MODE | $SPACES | $FOCUSED"
}

if ! get_chunk 2>/dev/null
then
    if ! get_kwm 2>/dev/null
    then
        echo "[ ] | (0) | rip wms :/"
    fi
fi
