if test -d "$HOME/sync/Life"
    set -x NOTE_DIR "$HOME/sync/Life"
else
    set -x NOTE_DIR "$HOME/Documents/Notes"
end
function notes
    cd $NOTE_DIR
    $EDITOR $NOTE_DIR
end
function daily
    cd $NOTE_DIR
    $EDITOR $NOTE_DIR/$(date +%Y-%m-%d).md
end

