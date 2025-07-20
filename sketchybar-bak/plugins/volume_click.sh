#!/bin/bash

WIDTH=150

detail_on() {
  sketchybar --animate tanh 10 --set volume_slider slider.width=$WIDTH
}

detail_off() {
  sketchybar --animate tanh 10 --set volume_slider slider.width=0
}

toggle_detail() {
  INITIAL_WIDTH=$(sketchybar --query volume_slider | jq -r ".slider.width")
  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    detail_on
  else
    detail_off
  fi
}

toggle_detail