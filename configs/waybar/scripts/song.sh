#!/usr/bin/env bash

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

# Remove stuff like (From "..."), [feat. ...], etc.
clean_title=$(echo "$title" | sed -E 's/\s*\(From.*\)//I; s/\s*\[.*\]//')

if [ -n "$clean_title" ]; then
  echo "{\"text\": \"$clean_title\", \"tooltip\": \"$artist\"}"
else
  echo "{\"text\": \"\", \"tooltip\": \"No song playing\"}"
fi
