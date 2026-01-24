#!/bin/bash

USER="emerson"
HOME_DIR="/home/$USER"
DEST_DIR="/home/misArchivos/Documentos/Scripts_Linux"

# Lista de enlaces a crear
declare -A LINKS=(
  ["loadmiConf.conf"]="$HOME_DIR/Documentos/Scripts_Linux/loadmiConf.conf"
  ["My_WindowsRules.conf"]="$DEST_DIR/My_WindowRules.conf"
  ["Ny_Startup_Apps.conf"]="$DEST_DIR/My_Startup_Apps.conf"
  ["UserKeybinds.conf"]="$DEST_DIR/UserKeybinds.conf"
)

echo "==> Creando enlaces simbólicos en $HOME_DIR"

for LINK_NAME in "${!LINKS[@]}"; do
  TARGET="${LINKS[$LINK_NAME]}"
  LINK_PATH="$HOME_DIR/$LINK_NAME"

  # Verificar que el archivo destino existe
  if [ ! -f "$TARGET" ]; then
    echo "⚠ AVISO: El archivo destino no existe:"
    echo "   $TARGET"
    echo "   Se omitirá este enlace."
    echo ""
    continue
  fi

  # Si existe un archivo/carpeta con el mismo nombre, se elimina
  if [ -e "$LINK_PATH" ] || [ -L "$LINK_PATH" ]; then
    echo "→ Eliminando archivo/enlace existente: $LINK_PATH"
    rm -f "$LINK_PATH"
  fi

  # Crear enlace simbólico
  echo "→ Creando enlace: $LINK_PATH -> $TARGET"
  ln -s "$TARGET" "$LINK_PATH"

  # Ajustar permisos del enlace (pero no del archivo destino)
  chown -h "$USER:$USER" "$LINK_PATH"
done

echo ""
echo "✔ Enlaces simbólicos creados correctamente."
