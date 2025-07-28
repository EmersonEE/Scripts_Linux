#!/bin/bash

# Habilitar modo estricto
set -e

# Variables
REPO_URL="https://github.com/JaKooLit/Arch-Hyprland.git"
DEST_DIR="$HOME/Arch-Hyprland"

echo "🔄 Clonando repositorio Arch-Hyprland en: $DEST_DIR"

# Verificar si ya existe el directorio
if [ -d "$DEST_DIR" ]; then
    echo "⚠️ El directorio $DEST_DIR ya existe. ¿Deseas eliminarlo y volver a clonar? [s/N]"
    read -r confirm
    if [[ "$confirm" =~ ^[sS]$ ]]; then
        rm -rf "$DEST_DIR"
    else
        echo "❌ Instalación cancelada."
        exit 1
    fi
fi

# Clonar el repositorio con profundidad mínima
git clone --depth=1 "$REPO_URL" "$DEST_DIR"

# Ir al directorio
cd "$DEST_DIR"

# Dar permisos de ejecución al instalador
chmod +x install.sh

# Ejecutar el instalador
echo "🚀 Ejecutando script de instalación..."
./install.sh

