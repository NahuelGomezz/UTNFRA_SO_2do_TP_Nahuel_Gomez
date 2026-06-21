#!/bin/bash
REPO_PATH="$HOME/UTN-FRA_SO_Examenes"
LISTA="$REPO_PATH/202406/bash_script/Lista_Usuarios.txt"
MI_APELLIDO="Gomez"
sudo su -c "cat << 'FIN1' > /usr/local/bin/${MI_APELLIDO}AltaUser-Groups.sh
#!/bin/bash
USUARIO_REF=\$1
LISTA_USUARIOS=\$2
CLAVE_HASH=\$(grep \"^\${USUARIO_REF}:\" /etc/shadow | awk -F ':' '{print \$2}')
while IFS=',' read -r USUARIO GRUPO HOME_DIR
do
    [[ \"\$USUARIO\" =~ ^#.* ]] && continue
    [ -z \"\$USUARIO\" ] && continue
    groupadd -f \"\$GRUPO\"
    useradd -m -s /bin/bash -g \"\$GRUPO\" -d \"\$HOME_DIR\" -p \"\$CLAVE_HASH\" \"\$USUARIO\"
done < \"\$LISTA_USUARIOS\"
FIN1
sudo chmod +x /usr/local/bin/${MI_APELLIDO}AltaUser-Groups.sh
sudo /usr/local/bin/${MI_APELLIDO}AltaUser-Groups.sh $(whoami) $LISTA
cp /usr/local/bin/${MI_APELLIDO}AltaUser-Groups.sh ~/RTA_Examen_20260620/
