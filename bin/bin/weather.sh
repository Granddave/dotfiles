#!/usr/bin/env bash

{
    response=$(/usr/bin/curl --silent --fail --connect-timeout 3 "wttr.in/Jonkoping?format=%C+%t")
    rc=$?
    if [ $rc -ne 0 ]; then
        echo "No internet";
    elif echo "$response" | grep -q "Unknown location"; then
        echo "wttr.in failed";
    else
        echo "$response"
    fi
} | tee "$HOME/.cache/weather"
