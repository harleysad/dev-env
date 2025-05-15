# Use the latest Debian image
FROM ubuntu:latest

# Copia o arquivo para dentro do contêiner
COPY entrypoint.sh /entrypoint.sh  
# Update package lists and install required tools
RUN apt-get update && \
    apt-get install -y \
    bash-completion curl wget net-tools unzip tar nano \
    vim htop neofetch tree lsof strace tmux git iputils-* \
    p7* sudo btop neovim build-essential && \
# Download and extract VS Code CLI
    curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz && \
    tar -xf vscode_cli.tar.gz && \
    rm vscode_cli.tar.gz && \
    chmod +x /entrypoint.sh  


# The container will run tail -f /dev/null to keep running
# ENTRYPOINT tail -f /teste.txt 
