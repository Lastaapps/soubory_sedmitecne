#!/bin/bash

limit=2
for name in "caprine" "Discord" # "youtube-music"
do
    for pid in $(pgrep "$name")
    do
        # cpulimit -l "$limit" -zi -p "$pid" &
        limitcpu -l "$limit" -z -m -q -p "$pid" &
    done
done

sleep 1
read -p "Press any key to resume ..."

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

