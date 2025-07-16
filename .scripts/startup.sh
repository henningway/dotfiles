#!/bin/bash
set -x

# starts the program given with $1 and moves it to the screen index given with $2
# this assumes that all screens are 1920 wide
start () { 
  $1 &
  sleep 4
  local PID=$(wmctrl -pl | tail -n1 | awk '{print $3}')
  local WID=$(xdotool search --pid "$PID" --onlyvisible | tail -n1)
  xdotool windowmove "$WID" $((1920*$2)) 0
  wmctrl -ir "$WID" -b add,maximized_vert,maximized_horz
  return $WID
}

start evolution 0
sleep 2
start firefox 1
sleep 2
start code 2
sleep 2
TERM_WID=$(start gnome-terminal 1)

xdotool windowactivate TERM_WID
xdotool type --delay 100 "~/.scripts/tmux.sh"
xdotool key "Return"

set +x
