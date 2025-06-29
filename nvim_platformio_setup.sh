#!/bin/bash
# Dotfile setup for Neovim + LazyVim + nvim-platformio.lua on CachyOS (Hyprland)
# This script will install all required tools, clone your config, and set up Neovim

set -e

# 1. Install required packages
sudo pacman -Syu --needed --noconfirm git base-devel cmake unzip ninja curl wget python nodejs npm

# 2. Install Neovim (latest stable)
sudo pacman -S --needed --noconfirm neovim

# 3. Install PlatformIO CLI
curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
python3 get-platformio.py

# Ensure pio is in PATH (may need to log out/in)
export PATH=$PATH:~/.platformio/penv/bin

# 4. Install Nerd Fonts for icons
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip -d firacode
fc-cache -fv
cd ~

# 5. Clone LazyVim starter config
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/LazyVim/starter.git nvim
cd nvim
rm -rf .git

# 6. Configure LazyVim for PlatformIO plugin
cat > ~/.config/nvim/lua/plugins/platformio.lua <<EOF
return {
  "anurag3301/nvim-platformio.lua",
  dependencies = {
    "akinsho/nvim-toggleterm.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("platformio").setup {
      lsp = "clangd",
      menu_key = "<leader>p",
    }
  end,
}
EOF

# 7. Launch Neovim to install plugins
nvim --headless \
  "+Lazy! sync" \
  +qa

# Done
echo "✅ Neovim + PlatformIO setup complete!"
echo "🚀 Launch Neovim and use :Pioinit to start a new project."
