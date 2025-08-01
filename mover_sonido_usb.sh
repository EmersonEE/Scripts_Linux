#!/bin/bash

carpeta_sonidos_root="/usr/share/sounds/freedesktop/stereo"
carpeta_sonidos="/home/emerson/Documentos/Scripts_Linux/Sonidos_USB"
script_sonidos="/home/emerson/Documentos/Scripts_Linux/usb-sound-watcher.sh"
hypr="/home/emerson/.config/hypr/UserScripts"

# Verificar que la carpeta de sonidos exista
if [ -d "$carpeta_sonidos" ]; then
    echo "Copiando sonidos..."
    sudo cp -r "$carpeta_sonidos" "$carpeta_sonidos_root"
else
    echo "❌ Carpeta de sonidos no encontrada: $carpeta_sonidos"
fi

# Verificar que el script existe
if [ -f "$script_sonidos" ]; then
    echo "Copiando script..."
    sudo cp "$script_sonidos" "$hypr"
else
    echo "❌ Script no encontrado: $script_sonidos"
fi

