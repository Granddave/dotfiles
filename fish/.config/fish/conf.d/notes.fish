if test -d "$HOME/sync/Life"
    set -x NOTE_DIR "$HOME/sync/Life"
    set -x DAILY_NOTE_DIR "$NOTE_DIR/Daily"
else
    set -x NOTE_DIR "$HOME/Documents/Notes"
    set -x DAILY_NOTE_DIR "$NOTE_DIR"
end
function notes
    cd $NOTE_DIR
    $EDITOR $NOTE_DIR
end
function daily
    cd $NOTE_DIR
    $EDITOR $DAILY_NOTE_DIR/$(date +%Y-%m-%d).md
end
function weekly
  $EDITOR $DAILY_NOTE_DIR/$(date +%Y-W%V).md
end
