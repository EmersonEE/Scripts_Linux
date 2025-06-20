#!/bin/bash

# Ruta a los sonidos
SOUND_CONNECT="/usr/share/sounds/freedesktop/stereo/device-added.oga"
SOUND_DISCONNECT="/usr/share/sounds/freedesktop/stereo/device-removed.oga"

# Verificá que sox esté instalado y play disponible
command -v play >/dev/null || {
    echo "El comando 'play' no está disponible. Instala sox: sudo pacman -S sox"
    exit 1
}

# Monitorea eventos de dispositivos USB
udevadm monitor --udev --subsystem-match=usb | while read -r line; do
    if echo "$line" | grep -q "add"; then
        play "$SOUND_CONNECT" >/dev/null 2>&1 &
    elif echo "$line" | grep -q "remove"; then
        play "$SOUND_DISCONNECT" >/dev/null 2>&1 &
    fi
done
