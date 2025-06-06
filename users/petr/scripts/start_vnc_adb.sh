#!/usr/bin/env bash

# Make sure your Android device is plugged in and accessible over adb.

#### Remember to enable virtual displays in xorg by adding the following to your configuration (e.g. /usr/share/X11/xorg.conf.d/20-virtual.conf)
# Section "Device"
#    Identifier "intelgpu0"
#    Driver "intel"
#    Option "VirtualHeads" "1"
#EndSection
#### If you use AMD or Nvidia, change the Identifier and Driver options to match your GPU.

#W=2000      # Virtual display width
#H=1200      # Virtual display height
W=1500      # Virtual display width
H=900      # Virtual display height
O=VIRTUAL1  # The name of the virtual display (check using xrandr)
P=eDP1      # The name of your physical display (check using xrandr)
PW="$(xrandr --current | grep \* | awk '{print $1;}' | cut -d x -f 1)"

# Create the virtual display
gtf $W $H 60 | sed '3q;d' | sed 's/Modeline//g' | xargs xrandr --newmode
gtf $W $H 60 | sed '3q;d' | sed 's/Modeline//g' | awk '{print $1;}' | sed 's/^.\(.*\).$/\1/' | xargs xrandr --addmode $O
gtf $W $H 60 | sed '3q;d' | sed 's/Modeline//g' | awk '{print $1;}' | sed 's/^.\(.*\).$/\1/' | xargs xrandr --output $O --right-of $P --mode

# Forward the VNC port to your device and start a VNC session
# Over ADB
adb reverse tcp:5900 tcp:5900
x11vnc -usepw -localhost -clip ${W}x${H}+${PW}+0

# Over network
#x11vnc -usepw -clip ${W}x${H}+${PW}+0
#x11vnc -usepw -ncache 10 -clip ${W}x${H}+${PW}+0

# When the session ends, turn off the virtual display
xrandr --output $O --off
