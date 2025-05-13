# Use the latest Debian image
FROM ubuntu:latest

# Update package lists and install required tools
RUN apt-get update && \
    apt-get install -y curl tar nginx

# Download and extract VS Code CLI
# RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz && \
#     tar -xf vscode_cli.tar.gz && \
#     rm vscode_cli.tar.gz

# The container will run tail -f /dev/null to keep running
CMD ["tail", "-f", "/dev/null"]

# CMD ["/code", "serve-web",  "--without-connection-token"]
# CMD ["nginx"]