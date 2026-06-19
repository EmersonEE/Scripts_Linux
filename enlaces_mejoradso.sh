#!/bin/bash

# Verificar si se proporcionó usuario
if [ -z "$1" ]; then
  echo "Uso: sudo $0 nombre_usuario"
  exit 1
fi

# El script debe ejecutarse como root para crear carpetas en /home y cambiar dueños
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta el script con sudo."
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

echo "--- Configuración de carpetas compartidas ---"

# 1. Verificar y crear la carpeta raíz compartida
if [ ! -d "$SHARED_DIR" ]; then
  echo "Creando carpeta compartida base: $SHARED_DIR"
  mkdir -p "$SHARED_DIR"
  # Asignamos permisos 777 para que cualquier usuario de cualquier distro 
  # pueda leer/escribir sin conflictos de UID/GID
  chmod 777 "$SHARED_DIR"
else
  echo "La carpeta compartida base ya existe."
  # Aseguramos permisos por si acaso
  chmod 777 "$SHARED_DIR"
fi

# Asegurar que el usuario existe en esta distro
if ! id "$USER" &>/dev/null; then
  echo "Error: El usuario '$USER' no existe en este sistema."
  exit 1
fi

echo "Configurando para el usuario: $USER"
echo ""

# 2. Crear enlaces simbólicos
for folder in "${FOLDERS[@]}"; do
  TARGET="$SHARED_DIR/$folder"
  LINK="$HOME_DIR/$folder"

  # Crear la carpeta de destino en la zona compartida si no existe
  if [ ! -d "$TARGET" ]; then
    echo "Creando carpeta de origen: $TARGET"
    mkdir -p "$TARGET"
    chmod 777 "$TARGET"
  fi

  # Borrar carpeta real en el Home si existe y no es un enlace
  if [ -d "$LINK" ] && [ ! -L "$LINK" ]; then
    echo "Eliminando carpeta local existente: $LINK"
    # Mover contenido antes de borrar podría ser más seguro, 
    # pero aquí seguimos tu lógica original de borrado limpio.
    rm -rf "$LINK"
  fi

  # Crear enlace simbólico si no existe
  if [ ! -L "$LINK" ]; then
    echo "Creando enlace: $LINK -> $TARGET"
    ln -s "$TARGET" "$LINK"
    # Cambiar el dueño del enlace para el usuario actual
    chown -h $USER:$USER "$LINK"
  else
    echo "El enlace ya existe: $LINK"
  fi
done

echo ""
echo "✔ Configuración completada correctamente."
echo "Nota: Se han aplicado permisos globales (777) en $SHARED_DIR para evitar conflictos entre distros."
