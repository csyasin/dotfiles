#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=0xffffffff
  slider.background.height=8
  slider.background.corner_radius=4
  slider.background.color=0x33ffffff
  slider.knob=􀀁
  slider.knob.drawing=on
  slider.knob.color=0xffffffff
  padding_left=0
  padding_right=0
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
)

sketchybar --add slider volume_slider right            \
           --set volume_slider "${volume_slider[@]}"   \
           --subscribe volume_slider volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"