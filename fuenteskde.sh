#!/bin/bash

# Actualizar repositorios
sudo pacman -Syu --noconfirm

# Instalar paquetes de fuentes usados en KDE Plasma
sudo pacman -S --noconfirm \
    noto-fonts \
    ttf-dejavu \
    ttf-liberation \
    ttf-freefont \
    ttf-droid \
    ttf-opensans \
    ttf-roboto \
    ttf-ubuntu-font-family \
    ttf-caladea \
    ttf-carlito \
    ttf-hack \
    noto-fonts-emoji \
    noto-fonts-cjk \
    noto-fonts-extra

# Actualizar caché de fuentes
fc-cache -fv

echo "✅ Fuentes de KDE Plasma instaladas correctamente."
