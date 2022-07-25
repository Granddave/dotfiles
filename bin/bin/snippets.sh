#!/bin/sh

SNIPS=${HOME}/sync/Snippets
FILE=$(find "${SNIPS}" -type f -printf "%f\n" | /usr/bin/rofi -dmenu)
SNIPPET="${SNIPS}/${FILE}"

if [ -f "${SNIPPET}" ]; then
    if [ -x "${SNIPPET}" ]; then
        DATA=$("${SNIPPET}")
    else
        DATA=$(head --bytes=-1 "${SNIPPET}")
    fi

    printf "%s" "$DATA" | xsel -p -i
    printf "%s" "$DATA" | xsel -b -i
    xdotool key shift+Insert
fi
