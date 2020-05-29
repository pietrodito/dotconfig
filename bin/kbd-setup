#!/bin/bash

do-the-trick () {
    setxkbmap -layout "us,us" -variant "basic,intl"
    setxkbmap -option grp:shifts_toggle
    setxkbmap -option ctrl:nocaps
    xcape -e 'Control_L=Escape'
}

around-lock-screen () {
  dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" |
    while read x; do
      case "$x" in
        *"boolean true"*) do-the-trick;;
        *"boolean false"*) do-the-trick;;
      esac
    done
}


do-the-trick
around-lock-screen &
