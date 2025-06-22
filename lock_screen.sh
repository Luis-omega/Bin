#!/bin/bash

LOCKER="swaylock"
BACKGROUND_PATH="$HOME/.local/share/idle_background.png"
LOCK_COLOR="000000"

LOCK_ARGS="-i $BACKGROUND_PATH -c $LOCK_COLOR  -s fit"

#command -v playerctl &> /dev/null && playerctl pause

$LOCKER $LOCK_ARGS &

sleep 1

# Verifica si el lock tuvo éxito (por ejemplo, no fue cancelado)
if [ $? -eq 0 ]; then
  systemctl suspend
fi
