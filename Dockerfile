# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Sven Hartmann <sid@sh87.net>

# Install dependencies
RUN echo "deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi" | tee --append /etc/apt/sources.list.d/pyload.list
RUN apt-get update && apt-get install -y \
    liblept3 python python-crypto \
	python-pycurl python-imaging tesseract-ocr zip \
	unzip build-dep rar unrar-nonfree \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get source -b unrar-nonfree
RUN dpkg -i unrar_4.1.4-1_armhf.deb
RUN rm -rf unrar_*

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]
