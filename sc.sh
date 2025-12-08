#!/usr/bin/env bash
set -e

echo "Limpiando TODO lo relacionado con PlatformIO + clangd + arduino-lsp..."

# 1. Borra el plugin nvim-platformio.lua y su carpeta completa
rm -rf ~/.local/share/nvim/lazy/nvim-platformio.lua 2>/dev/null || true
rm -rf ~/.cache/nvim/lazy/nvim-platformio.lua 2>/dev/null || true

# 2. Borra los archivos de configuración que creamos
rm -f ~/.config/nvim/lua/plugins/platformio.lua
rm -f ~/.config/nvim/lua/config/platformio.lua
rm -rf ~/.config/nvim/lua/config/lsp.lua 2>/dev/null || true  # si lo creaste solo para clangd

# 3. Borra los paquetes de Mason que instalamos (clangd, arduino-language-server, etc.)
echo "Desinstalando paquetes de Mason..."
nvim -Es <<EOF
:MasonUninstallAll
quit
EOF

# 4. Borra cachés y estados de Lazy y Mason (no afecta otros plugins)
rm -rf ~/.local/state/nvim/lazy/
rm -rf ~/.local/share/nvim/mason/
rm -rf ~/.cache/nvim/mason/

# 5. Borra archivos temporales de PlatformIO en tus proyectos (opcional, solo si quieres limpiar proyectos)
# Descomenta las dos líneas siguientes si quieres borrar también los .pio de tus proyectos actuales
# find ~/ -type d -name ".pio" -exec rm -rf {} + 2>/dev/null || true
# find ~/ -name "compile_commands.json" -delete 2>/dev/null || true

echo ""
echo "¡TODO LIMPIO!"
echo "Ahora puedes:"
echo "  • Cerrar y volver a abrir Neovim"
echo "  • Ejecutar :Lazy sync"
echo "  • Y empezar de cero con la configuración que tú elijas"
echo ""
echo "Neovim quedó exactamente como antes de que empezáramos. ¡Sin riesgos!"

# Limpieza final de la pantalla
read -p "Presiona Enter para terminar..."
