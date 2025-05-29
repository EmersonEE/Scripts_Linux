#!/bin/bash

# Actualizar repositorios
sudo pacman -Syu --noconfirm

# Instalar paquetes de fuentes usados en GNOME
sudo pacman -S --noconfirm \
    cantarell-fonts \
    noto-fonts \
    ttf-dejavu \
    ttf-liberation \
    ttf-freefont \
    ttf-opensans \
    ttf-roboto \
    ttf-ubuntu-font-family \
    ttf-fira-sans \
    ttf-fira-mono \
    noto-fonts-emoji \
    noto-fonts-cjk \
    noto-fonts-extra

# Actualizar caché de fuentes
fc-cache -fv

echo "✅ Fuentes de GNOME instaladas correctamente."

