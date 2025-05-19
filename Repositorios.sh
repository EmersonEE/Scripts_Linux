#!/bin/bash

# Directorio base donde se clonarán los repositorios
BASE_DIR="$HOME/Documentos"

# Crear el directorio si no existe
mkdir -p "$BASE_DIR"

# Lista de repositorios a clonar
REPOS=(
    "https://github.com/EmersonEE/ESP32_Trainer.git"
    "https://github.com/EmersonEE/PlatformIO.git"
    "https://github.com/EmersonEE/My_KiCad.git"
    "https://github.com/EmersonEE/Scripts_Linux.git"
)

# Cambiar al directorio base
cd "$BASE_DIR" || exit

# Clonar cada repositorio
for repo in "${REPOS[@]}"; do
    echo "Clonando $repo..."
    git clone "$repo"
done

echo "✅ Todos los repositorios fueron clonados en: $BASE_DIR"
