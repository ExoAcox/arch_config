#! /usr/bin/env bash

function launch_player() {
  kitty @ new-window ---title cover
  kitty @ send-text 'export PS1="" \r'
  change_cover
  kitty @ new-window --title ncmpcpp ncmpcpp
  kitty @ resize-window --increment 93
}

function change_cover() {
  kitty @ send-text \
    --match title:cover \
    'clear && kitty icat --transfer-mode=stream ~HOME/cover.jpg \r'
}

function extract_cover() {
  music_dir="/run/media/yuju/ENIGMA/Music/"
  temp_song="$HOME/current-song"

  cp "$music_dir/$(mpc --format %file% current)" "$temp_song"

  ffmpeg \
    -hide_banner \
    -loglevel 0 \
    -y \
    -i "$temp_song" \
    -vf scale=400:-1 \
    "$HOME/cover.jpg" > /dev/null 2>&1

  rm "$temp_song"
}

if [[ $1 == "extract" ]]; then
notify-send "jaucok"
  # extract_cover
  change_cover
else
  launch_player
fi
