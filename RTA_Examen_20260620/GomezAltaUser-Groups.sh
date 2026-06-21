#!/bin/bash
USUARIO_REF=$1
LISTA=$2
CLAVE_HASH=$(sudo grep "^${USUARIO_REF}:" /etc/shadow | awk -F ':' '{print $2}')
while IFS="," read -r USUARIO GRUPO HOME_DIR
do
    [[ "$USUARIO" =~ ^#.* ]] && continue
    [ -z "$USUARIO" ] && continue
    sudo groupadd -f "$GRUPO"
    sudo useradd -m -s /bin/bash -g "$GRUPO" -d "$HOME_DIR" -p "$CLAVE_HASH" "$USUARIO"
done < "$LISTA"
