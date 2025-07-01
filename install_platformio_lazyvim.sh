#!/bin/bash
# Dotfile setup for Neovim + LazyVim + nvim-platformio.lua on CachyOS (Hyprland)
# Improved version with validations, better LSP support, and error handling

set -e

# --- Funciones ---
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# --- 1. Verificar e instalar dependencias ---
echo "🔍 Verificando dependencias..."
REQUIRED_PKGS="git cmake unzip ninja curl wget python nodejs npm"
for pkg in $REQUIRED_PKGS; do
  if ! command_exists "$pkg"; then
    echo "⏳ Instalando $pkg..."
    sudo pacman -S --needed --noconfirm "$pkg" || echo "⚠️ Error al instalar $pkg"
  else
    echo "✅ $pkg ya está instalado."
  fi
done

# --- 2. Instalar Neovim (última versión) ---
if ! command_exists "nvim"; then
  echo "⏳ Instalando Neovim..."
  sudo pacman -S --needed --noconfirm neovim || {
    echo "⚠️ No se pudo instalar Neovim desde repos. Instalando desde AppImage..."
    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O ~/nvim.appimage
    chmod +x ~/nvim.appimage
    sudo mv ~/nvim.appimage /usr/local/bin/nvim
  }
fi

# --- 3. Instalar PlatformIO CLI ---
if ! command_exists "pio"; then
  echo "⏳ Instalando PlatformIO..."
  curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
  python3 get-platformio.py
  rm get-platformio.py
fi

# --- 4. Añadir PlatformIO al PATH ---
if ! grep -q "platformio/penv/bin" ~/.bashrc; then
  echo "📝 Añadiendo PlatformIO al PATH..."
  echo "export PATH=\$PATH:~/.platformio/penv/bin" >> ~/.bashrc
  echo "export PATH=\$PATH:~/.platformio/penv/bin" >> ~/.zshrc
  source ~/.bashrc
fi

# --- 5. Instalar LSPs para C/C++ y Rust ---
echo "📦 Instalando LSPs..."
sudo pacman -S --needed --noconfirm clang rust-analyzer

# --- 6. Instalar fuentes Nerd Fonts ---
echo "🔠 Instalando FiraCode Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip -q FiraCode.zip -d firacode
rm FiraCode.zip
fc-cache -fv
cd ~

# --- 7. Configurar LazyVim + PlatformIO ---
echo "⚙️ Configurando LazyVim..."
mkdir -p ~/.config
cd ~/.config
if [ ! -d "nvim" ]; then
  git clone https://github.com/LazyVim/starter.git nvim
  cd nvim
  rm -rf .git
else
  echo "✅ ~/.config/nvim ya existe. No se sobrescribirá."
fi

# --- 8. Añadir configuración para PlatformIO ---
mkdir -p ~/.config/nvim/lua/plugins
cat > ~/.config/nvim/lua/plugins/platformio.lua <<EOF
return {
  "anurag3301/nvim-platformio.lua",
  dependencies = {
    "akinsho/toggleterm.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("platformio").setup({
      lsp = "clangd",
      menu_key = "<leader>p",
      auto_open_menu = true,
      serial_monitor = {
        enabled = true,
        baud_rate = 115200,
      },
    })
  end,
}
EOF

# --- 9. Instalar plugins ---
echo "🔄 Instalando plugins de Neovim..."
nvim --headless "+Lazy! sync" +qa

# --- 10. Mensaje final ---
echo -e "\n✅ \033[1m¡Configuración completada!\033[0m"
echo -e "🚀 Inicia Neovim con: \033[1mnvim\033[0m"
echo -e "🔧 Comandos útiles de PlatformIO:"
echo -e "   :Pioinit       - Crear un nuevo proyecto"
echo -e "   :PioBuild      - Compilar"
echo -e "   :PioUpload     - Subir firmware"
echo -e "   :PioMonitor    - Abrir monitor serial\n"
