#!/usr/bin/env bash
#
# Snippet tool that adds text from either script output or plain files to the
# clipboard and pastes it with Shift+Insert.
#
# Heavily inspired by Calin Leafshade's video on text snippets:
# https://www.youtube.com/watch?v=PRgIxRl67bk
#
# Example of a executable snippet:
#
#   #!/usr/bin/env sh
#   printf '%s' "$(date '+%F')"

set -e

SNIPPET_DIR_PATH="$HOME/sync/Snippets"
[ ! -d "$SNIPPET_DIR_PATH" ] && exit 1

# TODO: Remove this legacy path moving logic
SEARCH_HISTORY_FILEPATH="$HOME/.local/state/snippet-history"
if [ ! -f "$SEARCH_HISTORY_FILEPATH" ]; then
    LEGACY_PATH="$HOME/.cache/snippet-history"
    if [ -f "$LEGACY_PATH" ]; then
        mv "$LEGACY_PATH" "$SEARCH_HISTORY_FILEPATH"
    else
        touch "$SEARCH_HISTORY_FILEPATH"
    fi
fi

AVAILABLE_SNIPPETS=$(find "$SNIPPET_DIR_PATH" -type f -printf "%f\n")
SEARCH_HISTORY=$(cat "$SEARCH_HISTORY_FILEPATH")
COMBINED_WITH_SCORE=$(echo -e "${AVAILABLE_SNIPPETS}\n${SEARCH_HISTORY}" | sed '/^$/d' | sort | uniq -c | sort -nr)
AVAILABLE_SNIPPETS_WITH_SCORE=$(awk -F' ' 'NR==FNR{++a[$1];next} ($2 in a)' <(echo "$AVAILABLE_SNIPPETS") <(echo "$COMBINED_WITH_SCORE"))
SNIPPET_FILENAME=$(echo "$AVAILABLE_SNIPPETS_WITH_SCORE" | awk '{ print $2 }' | /usr/bin/rofi -dmenu -matching fuzzy)
echo "$SNIPPET_FILENAME" >> "$SEARCH_HISTORY_FILEPATH"

SNIPPET_FILEPATH="$SNIPPET_DIR_PATH/$SNIPPET_FILENAME"
if [ -f "$SNIPPET_FILEPATH" ]; then
    if [ -x "$SNIPPET_FILEPATH" ]; then
        DATA=$("$SNIPPET_FILEPATH")
    else
        DATA=$(head --bytes=-1 "$SNIPPET_FILEPATH")
    fi

    printf "%s" "$DATA" | xsel --primary  --input
    printf "%s" "$DATA" | xsel --clipboard --input
    xdotool key Shift+Insert
fi
