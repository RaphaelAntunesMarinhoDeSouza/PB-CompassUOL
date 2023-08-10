#!/bin/bash

# Definindo o fuso horário como América/São_Paulo
export TZ=America/Sao_Paulo

# Obtendo a data e hora atual formatada
DATE=$(date '+%D-%M-%Y %H:%M:%S')

# Verificando o status do serviço Apache (httpd)
if systemctl is-active --quiet httpd; then
    # Se estiver ativo:
    STATUS="Online"          # Definindo o status como "Online"
    MESSAGE="O Apache está online."    # Definindo a mensagem associada ao status online
    FILENAME="apache_online.txt"  # Nome do arquivo para o status online
else
    # Se estiver inativo:
    STATUS="Offline"         # Definindo o status como "Offline"
    MESSAGE="O Apache está offline."   # Definindo a mensagem associada ao status offline
    FILENAME="apache_offline.txt"  # Nome do arquivo para o status offline
fi

# Registrando o status no arquivo de log
echo "$DATE httpd $STATUS - $MESSAGE" >> /root/efs/raphael/status.txt
