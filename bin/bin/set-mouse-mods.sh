#!/usr/bin/env bash

for id in $(/home/david/bin/get-mouse-id.sh 'Logitech G203'); do
    /home/david/bin/set-mouse-speed.sh 0 $id >/dev/null
    /home/david/bin/middle-click-scroll 1 $id >/dev/null
done
