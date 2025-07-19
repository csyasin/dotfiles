#!/bin/sh

# 获取未读邮件数量
UNREAD_COUNT=$(osascript -e 'tell application "Mail" to return the unread count of inbox')

# 空值保护
if [ -z "$UNREAD_COUNT" ]; then
  UNREAD_COUNT=0
fi

sketchybar --set "$NAME" label=${UNREAD_COUNT}