#!/bin/bash

space="${NAME#space::}"

apps="$(aerospace list-windows --workspace "$space")"

if [ -z "$apps"]; then

  sketchybar --set "$NAME" padding_left=0 padding_right=0 icon.drawing=off label.drawing=off

else

  result=""

  while IFS= read -r line; do

  # 取出双 | 中间部分并去掉首尾空白
  app_name="$(echo "$line" | cut -d'|' -f2 | xargs)"
  app_icon="$($CONFIG_DIR/plugins/icon_map.sh "$app_name")"

  # 拼接到 result
  result="$result $app_icon"
  done <<< "$apps"

  # 去掉开头空格
  result="${result# }"

  sketchybar --set "$NAME" padding_left=10 padding_right=10 icon.drawing=on label.drawing=on icon="$space" label="$result"
fi
