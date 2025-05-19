#!/bin/bash

# Actualizar los repositorios y el sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar Git
echo "Instalando Git..."
sudo pacman -S --noconfirm git

# Configurar opciones globales de Git
echo "Configurando Git con valores predeterminados..."

# Configurar nombre de usuario y correo electrónico
git config --global user.name "EmersonEE"
git config --global user.email "perezemerson85@gmail.com"

# Habilitar la interfaz de usuario
git config --global user.ui true

# No pedir credenciales 
git config --global credential.helper store

# Configurar la rama principal por defecto como "main"
git config --global init.defaultBranch main

# Configurar la gestión de saltos de línea
git config --global core.autocrlf input

# Configurar la cache de credenciales para no tener que ingresar la contraseña en cada operación
git config --global credential.helper cache

# Establecer un alias para 'git status' como 'gs' para escribir menos
git config --global alias.gs "status"

# Mostrar configuración global de Git
echo "Configuración global de Git:"
git config --global --list

echo "Git ha sido instalado y configurado correctamente."
