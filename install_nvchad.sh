#!/bin/bash
# Script para instalar NvChad y configurar un tema bonito para Hyprland (con transparencia y buen contraste)

set -e

# 1. Instalar Neovim si no está presente
sudo pacman -Syu --needed --noconfirm neovim git curl unzip

# 2. Eliminar configuraciones anteriores si existen
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim

# 3. Clonar NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# 4. Crear configuración personalizada
mkdir -p ~/.config/nvchad-custom/lua/custom

# 5. Escribir configuración base con tema "catppuccin-mocha" (buen contraste para Hyprland)
cat > ~/.config/nvchad-custom/lua/custom/chadrc.lua <<EOF
local M = {}

M.ui = {
  theme = "catppuccin",
  transparency = true,
}

return M
EOF

# 6. Apuntar NvChad a la custom folder
mkdir -p ~/.config/nvim/lua
ln -s ~/.config/nvchad-custom/lua/custom ~/.config/nvim/lua/custom

# 7. Lanzar Neovim para instalar todo
nvim --headless \
  "Lazy sync" \
  +qa

# 8. Mensaje final
echo "\n\u2705 NvChad instalado con el tema 'catppuccin' en modo transparente para Hyprland."
echo "\U0001F680 Lanza Neovim con 'nvim' y disfruta."

