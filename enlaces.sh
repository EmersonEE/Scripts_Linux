#!/bin/bash

# Verificar si se proporcionó usuario
if [ -z "$1" ]; then
  echo "Uso: $0 nombre_usuario"
  exit 1
fi

USER=$1
HOME_DIR="/home/$USER"
SHARED_DIR="/home/misArchivos"

# Lista de carpetas XDG estándar
FOLDERS=(
  "Descargas"
  "Documentos"
  "Imágenes"
  "Música"
  "Vídeos"
  "Público"
  "Plantillas"
)

echo "Configurando carpetas compartidas para: $USER"
echo "Home del usuario: $HOME_DIR"
echo "Carpeta compartida: $SHARED_DIR"
echo ""

# Asegurar que el usuario existe
if ! id "$USER" &>/dev/null; then
  echo "El usuario '$USER' no existe."
  exit 1
fi

# Crear enlaces simbólicos
for folder in "${FOLDERS[@]}"; do
  TARGET="$SHARED_DIR/$folder"
  LINK="$HOME_DIR/$folder"

  # Borrar carpeta real si existe y no es un enlace
  if [ -d "$LINK" ] && [ ! -L "$LINK" ]; then
    echo "Eliminando carpeta existente: $LINK"
    rm -rf "$LINK"
  fi

  # Crear enlace simbólico si no existe
  if [ ! -L "$LINK" ]; then
    echo "Creando enlace simbólico: $LINK -> $TARGET"
    ln -s "$TARGET" "$LINK"
    chown -h $USER:$USER "$LINK"
  else
    echo "El enlace simbólico ya existe: $LINK"
  fi

done

echo ""
echo "✔ Configuración completada para $USER"
