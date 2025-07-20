#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then

  front_app=(
    label="$INFO"
    # icon.font="sketchybar-app-font:Regular:14.0"
    # icon="$($CONFIG_DIR/plugins/icon_map.sh "$INFO")"
    icon.background.image="app.$INFO"
  )

  sketchybar --set "$NAME" "${front_app[@]}"
fi
