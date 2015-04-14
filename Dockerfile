# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Sven Hartmann <sid@sh87.net>

# Install dependencies
RUN apt-get update && apt-get install -y \
    
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]
