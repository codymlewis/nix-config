export EDITOR="nvim"

pgrep 'plasma' > /dev/null || /usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland
