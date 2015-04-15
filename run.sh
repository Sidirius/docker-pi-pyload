#!/bin/bash
docker run -idt --name pyload \
	-v /data/pyload/config:/root/.pyload \
	-v /data/media/downloads:/root/.pyload/Downloads \
	-p 8000:8000 \
	-p 7227:7227 \
	-p 30122:22 \
	sidirius/docker-pi-pyload
