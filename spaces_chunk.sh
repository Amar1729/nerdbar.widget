#!/bin/bash

chunkc=/usr/local/bin/chunkc

# returns:
# LHS | MHS | RHS
# LHS: type of tiling on space
# MHS: number of spaces (e.g. 1 2 (3))
# RHS: name of focused window

MODE=$($chunkc tiling::query -d mode)
case $MODE in
    bsp)
        LHS="[bsp]"
        ;;
    float)
        LHS="[float]"
        ;;
    monocle)
        WINDOWS=$($chunkc tiling::query -d windows)
        NUM_WIN=$(echo "$WINDOWS" | wc -l)
        LHS="[n/""$NUM_WIN""]"
        ;;
    *)
        LHS="[]"
        ;;
esac

# list of windows (use for monocle)
WINDOWS=$($chunkc tiling::query -d windows)


# get middle (how to w/ chunk?)
#MHS="0 (1)"
MHS="$($chunkc tiling::query -d id)"
MHS="($MHS)"

# get name of focused window
RHS=$($chunkc tiling::query -w tag)
# add '...' if longer than n
RHS=$(echo "$RHS" | head -c50)


echo "$LHS"" | ""$MHS"" | ""$RHS"
