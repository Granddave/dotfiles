#!/bin/bash

{
    response=$(/usr/bin/curl --silent --fail "wttr.in/?format=1")
    rc=$?
    if [ $rc -ne 0 ]; then
        echo "No internet";
    elif echo "$response" | grep -q "Unknown location"; then
        echo "wttr.in failed";
    else
        echo "$response"
    fi
} | tee /tmp/weather.txt
