#!/bin/bash

sketchybar --add event aerospace_workspace_change

space_item=(
  padding_left=0
  padding_right=0
  icon.drawing=off
  label.drawing=off
  script="$PLUGIN_DIR/aerospace_space.sh"
  label.font="sketchybar-app-font:Regular:14.0"
)

for space in $(aerospace list-workspaces --all); do

  item_name="space::$space"
  sketchybar  --add item "$item_name" left \
              --set "$item_name" "${space_item[@]}" \
              --subscribe "$item_name" aerospace_workspace_change
done

