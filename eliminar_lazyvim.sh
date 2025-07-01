#!/bin/bash
# Script para desinstalar LazyVim y toda su configuración personal en Neovim

set -e

echo "\U0001F5D1 Eliminando configuración de LazyVim en ~/.config/nvim..."
rm -rf ~/.config/nvim

echo "\U0001F5D1 Eliminando datos de LazyVim en ~/.local/share/nvim..."
rm -rf ~/.local/share/nvim

echo "\U0001F5D1 Eliminando estado de LazyVim en ~/.local/state/nvim..."
rm -rf ~/.local/state/nvim

echo "\U0001F5D1 Eliminando caché de LazyVim en ~/.cache/nvim..."
rm -rf ~/.cache/nvim

# Opcional: eliminar configuración de LSP o plugin adicional
if [ -d "~/.config/nvim.bak" ]; then
  echo "❌ Restaurando configuración previa de Neovim desde ~/.config/nvim.bak..."
  mv ~/.config/nvim.bak ~/.config/nvim
fi

echo "✅ LazyVim y su configuración fueron eliminados completamente."
echo "Puedes abrir Neovim con una nueva configuración en blanco usando 'nvim'."
