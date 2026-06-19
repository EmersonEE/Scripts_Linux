#!/bin/bash

# ----------------------------------------------------
# Script para instalar sonidos USB en Hyprland
# ----------------------------------------------------

# Comprobar si sox está instalado
if ! command -v play >/dev/null; then
    echo "SoX no está instalado. Instalando..."
    sudo pacman -S --noconfirm sox
fi

# Crear carpeta para scripts locales si no existe
mkdir -p ~/.local/bin

# Crear script de monitoreo USB
USB_SCRIPT="$HOME/.local/bin/usb-sound.sh"

cat > "$USB_SCRIPT" << 'EOF'
#!/bin/bash

# Rutas a los sonidos
SOUND_CONNECT="/usr/share/sounds/freedesktop/stereo/bell.oga"
SOUND_DISCONNECT="/usr/share/sounds/freedesktop/stereo/complete.oga"

# Verifica que 'play' esté disponible
command -v play >/dev/null || {
    echo "El comando 'play' no está disponible. Instala sox"
    exit 1
}

# Monitorea eventos USB
udevadm monitor --udev --subsystem-match=usb | while read -r line; do
    if echo "$line" | grep -q "add"; then
        play "$SOUND_CONNECT" >/dev/null 2>&1 &
    elif echo "$line" | grep -q "remove"; then
        play "$SOUND_DISCONNECT" >/dev/null 2>&1 &
    fi
done
EOF

# Hacer ejecutable el script
chmod +x "$USB_SCRIPT"

# Crear carpeta para servicios systemd de usuario si no existe
mkdir -p ~/.config/systemd/user

# Crear servicio systemd
SERVICE_FILE="$HOME/.config/systemd/user/usb-sound.service"

cat > "$SERVICE_FILE" << EOF
[Unit]
Description=Reproduce sonidos al conectar/desconectar USB

[Service]
ExecStart=$USB_SCRIPT
Restart=always
KillMode=process

[Install]
WantedBy=default.target
EOF

# Recargar systemd y habilitar el servicio
systemctl --user daemon-reload
systemctl --user enable usb-sound.service
systemctl --user start usb-sound.service

echo "✅ Configuración completa. El servicio está corriendo en segundo plano."
echo "Prueba conectando o desconectando un USB para escuchar los sonidos."
