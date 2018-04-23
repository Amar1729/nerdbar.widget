#!/bin/bash

# Helper script that calls spaces_chunk (and then spaces_kwm, if first errors) or returns empty template str

if ! ./spaces_chunk.sh 2>/dev/null
then
    if ! ./spaces_kwm.sh 2>/dev/null
    then
        echo "[ ] | (0) | rip wms :/"
    fi
fi
