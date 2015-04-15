#!/bin/bash
docker stop pyload && docker rm pyload
docker build --rm -t sidirius/docker-pi-pyload .
