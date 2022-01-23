#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --primary --mode 3440x1440 --pos 1918x0 --rate 144 --rotate normal --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 0x180 --rate 144 --rotate normal --output DP-5 --off

setxkbmap -option ctrl:nocaps

xset r rate 200 30

#autorandr horizontal
run nm-applet
#run caffeine
run pamac-tray
run variety
run xfce4-power-manager
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
#run nitrogen --restore
run conky -c $HOME/.config/awesome/system-overview
#you can set wallpapers in themes as well
# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#run applications from startup
#run firefox
#run atom
#run dropbox
#run insync start
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop
