#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ ##
# Enhanced Rainbow Border Animation Script for Hyprland

# Configuración ajustable
ANIMATION_SPEED=0.5  # Velocidad de la animación (en segundos)
GRADIENT_ANGLE=270   # Ángulo del gradiente (en grados)
BORDER_SIZE=3        # Grosor del borde
ACTIVE_OPACITY=1.0   # Opacidad borde activo
INACTIVE_OPACITY=0.7 # Opacidad borde inactivo

# Genera un color hexadecimal aleatorio con buen contraste
generate_random_hex() {
    # Genera componentes más vibrantes
    r=$(( 128 + RANDOM % 128 ))
    g=$(( 128 + RANDOM % 128 ))
    b=$(( 128 + RANDOM % 128 ))
    printf "0xff%02x%02x%02x" $r $g $b
}

# Genera una paleta de colores armoniosa
generate_colors() {
    local count=${1:-8}  # Por defecto 8 colores
    colors=()
    
    # Base hue (tono base)
    local base_hue=$(( RANDOM % 360 ))
    
    for ((i=0; i<count; i++)); do
        # Variación del tono para armonía
        local hue=$(( (base_hue + i * (360/count)) % 360 ))
        
        # Convert HSV to RGB (más vibrante)
        local h=$(( hue / 60 ))
        local f=$(( hue % 60 ))
        local p=$(( 255 * 70 / 100 ))
        local q=$(( 255 * (100 - f * 70 / 60) / 100 ))
        local t=$(( 255 * (100 - (60 - f) * 70 / 60) / 100 ))
        
        case $h in
            0) colors+=("0xff$(printf "%02x%02x%02x" 255 $t $p)") ;;
            1) colors+=("0xff$(printf "%02x%02x%02x" $q 255 $p)") ;;
            2) colors+=("0xff$(printf "%02x%02x%02x" $p 255 $t)") ;;
            3) colors+=("0xff$(printf "%02x%02x%02x" $p $q 255)") ;;
            4) colors+=("0xff$(printf "%02x%02x%02x" $t $p 255)") ;;
            5) colors+=("0xff$(printf "%02x%02x%02x" 255 $p $q)") ;;
        esac
    done
    
    echo "${colors[@]}"
}

# Aplica la configuración inicial
apply_settings() {
    # Configuración del borde
    hyprctl keyword general:border_size $BORDER_SIZE
    hyprctl keyword general:col.active_border $(generate_colors 8) $GRADIENT_ANGLE
    hyprctl keyword general:col.inactive_border $(generate_colors 8) $GRADIENT_ANGLE
    hyprctl keyword decoration:active_opacity $ACTIVE_OPACITY
    hyprctl keyword decoration:inactive_opacity $INACTIVE_OPACITY
}

# Animación del borde
animate_border() {
    while true; do
        # Rotar los colores para efecto animado
        new_colors=($(generate_colors 8))
        hyprctl keyword general:col.active_border "${new_colors[@]}" $GRADIENT_ANGLE
        
        # Pequeña variación en el ángulo para efecto dinámico
        hyprctl keyword general:col.active_border "${new_colors[@]}" $(( (GRADIENT_ANGLE + RANDOM % 10 - 5) % 360 ))
        
        sleep $ANIMATION_SPEED
    done
}

# Ejecución principal
main() {
    apply_settings
    animate_border
}

main
