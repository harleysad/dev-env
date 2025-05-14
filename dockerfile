# Use the latest Debian image
FROM ubuntu:latest

# ENV SENHA_UBT=essa_senha_deve_ser_sobreescrita!
ARG SENHA_UBT
ENV SENHA_UBTI=${SENHA_UBT}

# Update package lists and install required tools
# RUN apt-get update && \
#     apt-get install -y \
#     bash-completion curl wget unzip tar nano \
#     vim htop neofetch tree lsof strace tmux git \
#     p7* sudo btop neovim   
    
# Download and extract VS Code CLI

RUN usermod -aG sudo ubuntu && \
    echo "ubuntu:${SENHA_UBTI}" > teste.txt
    # rm vscode_cli.tar.gz && \ 
    # curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz && \
    # tar -xf vscode_cli.tar.gz && \
    # echo "ubuntu:"$SENHA_UBT > teste.txt && \
    # echo "ubuntu":$SENHA_UBT | chpasswd  
    
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
USER ubuntu
# CMD /code serve-web --host 0.0.0.0 --port 80 --without-connection-token --server-base-path /base-path --server-data-dir /data-dir


# The container will run tail -f /dev/null to keep running
CMD tail -f /teste.txt 

# CMD ["/code", "serve-web",  "--without-connection-token"]
# CMD ["nginx", "-g", "daemon off;"]