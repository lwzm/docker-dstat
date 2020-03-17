#!/bin/sh

# https://stackoverflow.com/questions/911168/how-to-detect-if-my-shell-script-is-running-through-a-pipe
if [ -t 1 ]; then
    exec "$@"
else
    exec ttyd -p 80 "$@"
fi
