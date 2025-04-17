#!/bin/sh

# [... default stuff that your distro may throw in here ...] #


# Set the default X cursor to the usual pointer
xsetroot -cursor_name left_ptr

# Set a nice background
feh --bg-fill --no-fehbg ~/repos/archinstall/dotfiles/haskell.png

# Fire up screensaver
xscreensaver -no-splash &

# Power Management
xfce4-power-manager &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

exec xmonad
