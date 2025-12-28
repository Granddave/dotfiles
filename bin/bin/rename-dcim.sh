#!/usr/bin/env bash
for f in *.jpg *.mp4; do
  [ -e "$f" ] || continue
  ts=$(stat -c '%y' "$f" | sed 's/[-:]//g; s/ /_/; s/\..*//')
  ext="${f##*.}"
  new_name="${ts}.${ext}"
  # echo "${new_name}"
  mv -n -- "${f}" "${new_name}"
done
