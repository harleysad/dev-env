#!/bin/sh

USER_ID=1000 # Id do primeiro usuario linux
USER_NAME="Coder"
PASSWORD=$SENHA_UBT
DATADIR=$VSCODE_DATA_DIR
GROUP="users"

# Verifica se o grupo 'users' existe
if ! getent group $GROUP > /dev/null 2>&1; then
    # se nao existe cria
    sudo groupadd $GROUP
fi
# Verifica se já existe um usuário com o UID fornecido
if getent passwd "$USER_ID" >/dev/null 2>&1; then
    # Armazena o nome original
    USER_NAMEI=$(getent passwd "$USER_ID" | cut -d: -f1)
    # Altera o nome do usuario parão para o da variavel
    usermod -l $USER_NAME $USER_NAMEI
    # Ajusta o diretório home
    mv /home/$USER_NAMEI /home/$USER_NAME
    usermod -d /home/$USER_NAME -m $USER_NAME
else
    # cria o novo usuário
    useradd -m -u $USER_ID -s /bin/bash $USER_NAME
fi

# Muda o grupo parao do usuário
sudo usermod -g $GROUP $USER_NAME
# Altera a senha
echo "$USER_NAME:$PASSWORD" | chpasswd
# Usuario vai ter sudo

usermod -aG sudo $USER_NAME
# Acesso a pastas compartilhadas
chown -R "$USER_NAME:$GROUP" /home/shared
# Acesso de leitura no grupo para as pastas shared
find /home/shared -type d -exec chmod g+wx {} + chmod -R g+w /home/shared

# -----------------------------------------------------------------------------
# vscode parameters
# -----------------------------------------------------------------------------
# /code serve-web -h
# Runs a local web version of Visual Studio Code
# Usage: code serve-web [OPTIONS]
# Options:
#       --host <HOST>
#           Host to listen on, defaults to 'localhost'
#       --socket-path <SOCKET_PATH>        
#       --port <PORT>
#           Port to listen on. If 0 is passed a random free port is picked [default: 8000]
#       --connection-token <CONNECTION_TOKEN>
#           A secret that must be included with all requests
#       --connection-token-file <CONNECTION_TOKEN_FILE>
#           A file containing a secret that must be included with all requests
#       --without-connection-token
#           Run without a connection token. Only use this if the connection is secured by other means
#       --accept-server-license-terms
#           If set, the user accepts the server license terms and the server will be started without a user prompt
#       --server-base-path <SERVER_BASE_PATH>
#           Specifies the path under which the web UI and the code server is provided
#       --server-data-dir <SERVER_DATA_DIR>
#           Specifies the directory that server data is kept in
# GLOBAL OPTIONS:
#       --cli-data-dir <CLI_DATA_DIR>  Directory where CLI metadata should be stored [env: VSCODE_CLI_DATA_DIR=]
#       --verbose                      Print verbose output (implies --wait)
#       --log <level>                  Log level to use [possible values: trace, debug, info, warn, error, critical, off]
# -----------------------------------------------------------------------------


# Executa a aplicação com o usuário especificado
exec su - $USER_NAME -c "umask 0002 && \
                        /code serve-web \
                        --host 0.0.0.0 --port 80 \
                        --without-connection-token \
                        --server-base-path ~/ \
                        --server-data-dir $DATADIR"
# tail -f /dev/null