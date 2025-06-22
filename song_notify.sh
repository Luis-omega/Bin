#!/bin/bash

# Definir el nombre del script para evitar ejecuciones múltiples
LOCK_FILE="/tmp/playerctl_notify.lock"
SCRIPT_NAME="song_notify.sh"

# Verificar si el script ya está corriendo
if [ -e "$LOCK_FILE" ]; then
    echo "El script ya está en ejecución."
    exit 1
fi

# Crear el archivo de bloqueo para prevenir ejecución múltiple
touch "$LOCK_FILE"

# Capturar el PID del script y escribirlo en el archivo de bloqueo
echo $$ > "$LOCK_FILE"

# Función para limpiar el archivo de bloqueo cuando el script termina
cleanup() {
    rm -f "$LOCK_FILE"
}

# Asegurarse de que el archivo de bloqueo se elimine al terminar el script
trap cleanup EXIT

# Variables para almacenar el estado previo y la URI previa
previous_uri=""
previous_status=""

# Comando combinado para obtener el estado y la URI de la imagen
{
    playerctl -F status &
    playerctl -F metadata mpris:artUrl;
} | while read status_or_url; do
    # Si la línea está vacía, ignorarla
    if [ -z "$status_or_url" ]; then
        continue
    fi
    echo $status_or_url
    # Comprobar si la línea es una URI o un estado
    if [[ "$status_or_url" =~ ^file:// ]]; then
        # Es una URI de la imagen
        current_uri="$status_or_url"
    else
        # Es el estado de reproducción (Playing o Paused)
        current_status="$status_or_url"
    fi

    # Si el estado ha cambiado a "Playing" y la URI es diferente, enviar la notificación
    if [[ "$current_status" == "Playing" ]]; then
        name=$(playerctl metadata xesam:title)
        notify-send "Playing song:" "$name" -i "$current_uri" -a "Song notifier" -u low -t 2000
        previous_uri="$current_uri"
    fi

    # Actualizar el estado previo
    previous_status="$current_status"
done
