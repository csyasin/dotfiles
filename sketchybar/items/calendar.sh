#!/bin/sh

calendar=(
  update_freq=10
  icon=􀉉
  script="$PLUGIN_DIR/calendar.sh"
  click_script="open -a Calendar"
)

sketchybar --add item calendar right \
           --set calendar "${calendar[@]}"