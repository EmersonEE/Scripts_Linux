#!/bin/bash

echo "== Eliminando paquetes de KiCad =="
sudo pacman -Rns kicad kicad-library kicad-library-3d

echo "== Buscando otros paquetes relacionados =="
pacman -Qs kicad

echo "== Eliminando huérfanos =="
sudo pacman -Rns $(pacman -Qdtq 2>/dev/null)

echo "== Borrando configuraciones del usuario =="
rm -rf ~/.config/kicad
rm -rf ~/.local/share/kicad
rm -rf ~/.cache/kicad

echo "== KiCad eliminado por completo =="
