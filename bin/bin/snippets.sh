#!/bin/sh

SNIPS=${HOME}/sync/Snippets
FILE=$(find "${SNIPS}" -type f -printf "%f\n" | /usr/bin/rofi -dmenu -matching fuzzy)
SNIPPET="${SNIPS}/${FILE}"

if [ -f "${SNIPPET}" ]; then
    if [ -x "${SNIPPET}" ]; then
        DATA=$("${SNIPPET}")
    else
        DATA=$(head --bytes=-1 "${SNIPPET}")
    fi

    printf "%s" "$DATA" | xsel --primary  --input
    printf "%s" "$DATA" | xsel --clipboard --input
    xdotool key shift+Insert
fi
