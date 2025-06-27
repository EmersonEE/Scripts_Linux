#!/bin/bash

echo "=== Instalando Mosquitto y clientes MQTT ==="
sudo pacman -Sy --noconfirm mosquitto mosquitto-clients

echo "=== Habilitando y arrancando el servicio Mosquitto ==="
sudo systemctl enable --now mosquitto.service

echo "=== Configurando Mosquitto para escuchar en todas las interfaces ==="
MOSQUITTO_CONF="/etc/mosquitto/mosquitto.conf"

# Hacer backup
sudo cp $MOSQUITTO_CONF ${MOSQUITTO_CONF}.bak

# Sobrescribir configuración mínima
sudo bash -c "cat > $MOSQUITTO_CONF" <<EOF
listener 1883
allow_anonymous true
EOF

echo "=== Reiniciando Mosquitto ==="
sudo systemctl restart mosquitto.service

echo "=== Verificando si ufw está instalado ==="
if ! command -v ufw &> /dev/null; then
    echo "Instalando ufw..."
    sudo pacman -S --noconfirm ufw
    sudo systemctl enable --now ufw
fi

echo "=== Permitimos tráfico MQTT (puerto 1883) ==="
sudo ufw allow 1883/tcp

echo "=== Estado del firewall: ==="
sudo ufw status

echo "=== Verificación final: Mosquitto debería estar corriendo en el puerto 1883 ==="
sudo ss -tuln | grep 1883

echo "✅ Mosquitto instalado y listo para usar con conexiones desde red local."

