#!/bin/bash

# Actualizamos la base de datos de paquetes
echo "Actualizando la base de datos de paquetes..."
sudo pacman -Sy

# Instalamos los paquetes con pacman
echo "Instalando paquetes desde los repositorios oficiales..."
sudo pacman -S --noconfirm sox mosquitto cava cmatrix google-chrome visual-studio-code-bin mpv telegram-desktop papirus-icon-theme ttf-cascadia-code  otf-cascadia-code libreoffice-fresh  libreoffice-fresh-es python-virtualenv htop  qbittorrent spotify  spotify-adblock-git youtube-music-bin platformio-core platformio-core-udev

 
 
# Instalando UFW
echo "Instalando UFW"
sudo pacman -S  --noconfirm ufw ranger python-pillow 

# Habilitando ufw
echo "Habilitando ufw"
sudo ufw enable

sudo ufw allow 1883/tcp

#Arreglar hora dual boot
sudo timedatectl set-local-rtc 1

echo "Instalando KiCad"
sudo pacman -Syu  --noconfirm kicad

echo "Instalando Librerias Kicas"
sudo pacman -Syu  --noconfirm --asdeps kicad-library kicad-library-3d


# Instalamos yay para poder instalar paquetes AUR
echo "Instalando yay (AUR helper)..."
sudo pacman -S --noconfirm yay

# Instalamos Mullvad Browser desde AUR
echo "Instalando Mullvad Browser desde AUR..."
yay -S --noconfirm mullvad-browser-bin mqttx-bin

# Instalamos flatpak
echo "Instalando Flatpak..."
sudo pacman -S --noconfirm flatpak

# Actualizamos flatpak
echo "Actualizando Flatpak..."
flatpak update -y

# Verificamos que todo esté bien instalado
echo "Verificando instalaciones..."
pacman -Q cava cmatrix google-chrome visual-studio-code-bin mpv telegram-desktop yay flatpak mullvad-browser-bin

echo "¡Instalación completa!"
