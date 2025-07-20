#!/bin/bash

WIDTH=150

volume_change() {
  VOLUMN_ICON_LABEL="$INFO%"

  case $INFO in
    [6-9][0-9]|100) ICON=􀊩
    ;;
    [3-5][0-9]) ICON=􀊧
    ;;
    [1-9]|[1-2][0-9]) ICON=􀊥
    ;;
    *) ICON=􀊣; VOLUMN_ICON_LABEL=MUTE
  esac

  sketchybar --set volume_icon icon=$ICON label=$VOLUMN_ICON_LABEL \
             --set $NAME slider.percentage=$INFO

  INITIAL_WIDTH="$(sketchybar --query $NAME | jq -r ".slider.width")"

  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    sketchybar --animate tanh 10 --set $NAME slider.width=$WIDTH
  fi

  sleep 2

  # Check wether the volume was changed another time while sleeping
  FINAL_PERCENTAGE="$(sketchybar --query $NAME | jq -r ".slider.percentage")"

  if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
    sketchybar --animate tanh 10 --set $NAME slider.width=0
  fi
}

mouse_clicked() {
  osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
  "volume_change") volume_change
  ;;
  "mouse.clicked") mouse_clicked
  ;;
esac