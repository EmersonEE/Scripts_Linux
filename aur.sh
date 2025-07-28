#!/bin/bash

set -e

echo "🔐 Importando clave primaria de Chaotic-AUR..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || {
    echo "❌ Error al recibir la clave"
    exit 1
}
sudo pacman-key --lsign-key 3056513887B78AEB

echo "✅ Clave importada correctamente"

echo "📦 Instalando chaotic-keyring y mirrorlist..."
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo "✅ Keyring y mirrorlist instalados"

echo "📝 Verificando /etc/pacman.conf..."

if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
    echo "✅ chaotic-aur añadido a /etc/pacman.conf"
else
    echo "ℹ️ chaotic-aur ya está en /etc/pacman.conf"
fi

echo "🎉 Instalación completada. Puedes usar paquetes desde chaotic-aur."

