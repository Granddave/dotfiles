#!/bin/sh

if [ -e "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

# start Gnome keyring
if [ -f /usr/bin/gnome-keyring-daemon ]; then
  dbus-update-activation-environment --systemd DISPLAY
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi
echo "run"> /home/david/xsession
