#!/bin/bash

chunkc=/usr/local/bin/chunkc

# returns:
# LHS | MHS | RHS
# LHS: type of tiling on space
# MHS: number of spaces (e.g. 1 2 (3))
# RHS: name of focused window

get_chunk() {

    # Test if chunkc is active/exists first
    if ! MODE=$($chunkc tiling::query -d mode)
    then
        echo " [] | () | ~~ "
        exit 0
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

get_chunk 2>/dev/null
