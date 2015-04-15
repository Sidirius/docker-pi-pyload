# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Sven Hartmann <sid@sh87.net>

### Install Applications DEBIAN_FRONTEND=noninteractive  --no-install-recommends
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
RUN echo "deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi" | tee --append /etc/apt/sources.list
RUN apt-get update && apt-get clean
RUN apt-get install -y apt-utils
RUN apt-get install -y openssh-server supervisor git
RUN apt-get install -y python python-crypto python-pycurl python-imaging
RUN apt-get install -y liblept3 tesseract-ocr 
RUN apt-get install -y zip unzip
RUN apt-get install -y dpkg-dev
RUN apt-get build-dep -y unrar-nonfree
RUN apt-get source -b unrar-nonfree && \
	dpkg -i unrar*.deb && \
	rm -rf unrar_*
RUN apt-get install -y screen
RUN mkdir -p /var/run/sshd
RUN chmod 755 /var/run/sshd
RUN mkdir -p /var/log/supervisor

### Checkout pyload sources
RUN git clone https://github.com/pyload/pyload.git /opt/pyload

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
ADD supervisord.conf /

### Add pyLoad config
ADD pyload /root/.pyload

### Expose ports
EXPOSE 22 8000 7227

### Add startup.sh
ADD startup.sh /

### Set Entrypoint
ENTRYPOINT ["/startup.sh"]
