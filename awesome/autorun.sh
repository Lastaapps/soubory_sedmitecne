#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

## run (only once) processes which spawn with different name
# enable lock screen
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
    gnome-keyring-daemon --daemonize --login &
fi
# start audio
if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi

run nm-applet
run light-locker --lock-on-lid # usage: light-locker-command -l
run thunar --daemon
run wluma
run syncthing
run kdeconnect-indicator
run eval $(ssh-agent)
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

if (command -v system-config-printer-applet && ! pgrep applet.py ); then
  system-config-printer-applet &
fi

