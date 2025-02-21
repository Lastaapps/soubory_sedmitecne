#!/usr/bin/env bash

until ping -c 1 -W 1 8.8.8.8 &> /dev/null
do
    echo "[WaitForNet]: Retrying..."
    # sleep 1 - already in the ping command
done

sh -c "$1"

