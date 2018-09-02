#!/usr/local/bin/python3

# why the fuck doesn't this work (Mac Sierra, chunkwm)????
#!/usr/bin/env python3

import json
import os
from subprocess import Popen, PIPE

# attempt to get the space id
def get_space():
    KWM_CMD = '/usr/local/bin/kwmc query space active id'.split(' ')
    CHUNK_CMD = '/usr/local/bin/chunkc tiling::query --desktop id'.split(' ')

    try:
        # attempt newer WM first
        _p = Popen(CHUNK_CMD, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    except:
        # deprecated WM
        _p = Popen(KWM_CMD, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    finally:
        output, _ = _p.communicate()
        space = output.decode().strip()
        return space

    # if nothing works:
    return 1

def get_file(space):
    path = os.path.expanduser("~/.cache/wal/")

    fn = "colors_{}.json".format(space)
    if not os.path.exists(os.path.join(path, fn)):
        # this file is created manually (after wp -   w)
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
