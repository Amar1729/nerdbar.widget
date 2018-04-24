#!/usr/bin/env python3

import json
import os
from subprocess import Popen, PIPE

def get_kwmc_space():
    p = Popen(['kwmc', 'query', 'space', 'active', 'id'], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate()

    space = output.decode().strip()

    return space

def get_chunkc_space():
    pass

# function to determine whether to call kwmc or chunkwm?
def get_space():
    try:
        return get_kwmc_space()
    except:
        return get_chunkc_space()


def get_file(space):
    path = os.path.expanduser("~/.cache/wal/")

    fn = "colors_{}.json".format(space)
    if not os.path.exists(os.path.join(path, fn)):
        fn = "colors_1.json"

    return os.path.join(path, fn)

def get_colors(space):
    with open(get_file(space)) as f:
        content = json.load(f)

    return (content['special']['background'], content['colors']['color1'])

def main():
    space = get_space()
    bg, c1 = get_colors(space)

    print("{}:::{}:::{}".format(space, bg, c1))

main()
