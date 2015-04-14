# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Sven Hartmann <sid@sh87.net>

### Install Applications DEBIAN_FRONTEND=noninteractive  --no-install-recommends
RUN apt-get update && apt-get clean
RUN apt-get install -y \
	python-crypto python-pycurl tesseract-ocr git openssh-server supervisor \
	liblept3 python python-crypto python-pycurl python-imaging tesseract-ocr zip unzip \
	build-dep rar unrar-nonfree
RUN apt-get source -b unrar-nonfree
RUN dpkg -i unrar_4.1.4-1_armhf.deb
RUN rm -rf unrar_*
RUN mkdir -p /var/run/sshd
RUN chmod 755 /var/run/sshd
RUN mkdir -p /var/log/supervisor

### Checkout pyload sources
RUN git clone https://github.com/pyload/pyload.git /opt/pyload

### Add PyLoad Config Dir
ADD pyload /opt/.pyload

### Configure ssh
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

### Clean
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove

### Configure Supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

### Volume
VOLUME ["/opt/downloads"]

### Expose ports
EXPOSE 22 8000 7227

### Start Supervisor
CMD ["/usr/bin/supervisord","-n"]
