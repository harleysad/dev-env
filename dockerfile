# Use the latest Debian image
FROM ubuntu:latest

# Update package lists and install required tools
RUN apt-get update && \
    apt-get install -y \
    bash-completion curl wget unzip tar nano \
    vim htop neofetch tree lsof strace tmux git \
    p7* sudo btop neovim && \
# Download and extract VS Code CLI
    curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz && \
    tar -xf vscode_cli.tar.gz && \
    rm vscode_cli.tar.gz 
    
# USER ubuntu
# CMD /code serve-web --host 0.0.0.0 --port 80 --without-connection-token --server-base-path /base-path --server-data-dir /data-dir

# The container will run tail -f /dev/null to keep running
ENTRYPOINT tail -f /teste.txt 
