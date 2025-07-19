#!/bin/sh

mail=(
  icon=􀍛
  update_freq=120
  script="$PLUGIN_DIR/mail.sh"
  click_script="open -a Mail"
)

sketchybar --add item mail right \
           --set mail "${mail[@]}"