# Use the latest Debian image
FROM debian:latest

# Update package lists (optional)
RUN apt-get update

# Install any desired packages here (optional)
# RUN apt-get install -y <package-name>

# The container will run tail -f /dev/null to keep running
CMD ["tail", "-f", "/dev/null"]
