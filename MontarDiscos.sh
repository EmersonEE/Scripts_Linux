#!/bin/bash

# Requiere sudo para todo
if [[ $EUID -ne 0 ]]; then
   echo "Por favor ejecuta con: sudo $0"
   exit 1
fi

# Variables de montaje
DIR1="/mnt/DiscoPrincipal"
DIR2="/mnt/DiscoLaptop"

UUID1="01DA75ACC3514980"
UUID2="01DA75CB30F67500"

# Crear directorios de montaje
echo "Creando directorios si no existen..."
mkdir -p "$DIR1"
mkdir -p "$DIR2"

# Instalar ntfs-3g si no está instalado
if ! pacman -Qi ntfs-3g &>/dev/null; then
    echo "Instalando ntfs-3g..."
    pacman -S --noconfirm ntfs-3g
else
    echo "ntfs-3g ya está instalado."
fi

# Copia de seguridad del fstab
echo "Haciendo copia de seguridad de /etc/fstab en /etc/fstab.bak..."
cp /etc/fstab /etc/fstab.bak

# Añadir entradas al fstab si no existen
echo "Agregando entradas al /etc/fstab..."

grep -q "$UUID1" /etc/fstab || echo "UUID=$UUID1   $DIR1   ntfs-3g   defaults,nofail,uid=1000,gid=1000,umask=022   0 0" >> /etc/fstab
grep -q "$UUID2" /etc/fstab || echo "UUID=$UUID2   $DIR2   ntfs-3g   defaults,nofail,uid=1000,gid=1000,umask=022   0 0" >> /etc/fstab

# Recargar demonios
echo "Recargando systemd..."
systemctl daemon-reload

# Montar todo
echo "Montando unidades..."
mount -a

echo "Listo. Verifica con: lsblk -f"
