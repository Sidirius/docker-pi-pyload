#!/bin/bash
mkdir /var/run/sshd
if [ ! -f /root/.pyload/files.db ]
then
    python /opt/pyload/pyLoadCore.py
    sleep 3
    pkill python
fi
#/usr/bin/supervisord -c /supervisord.conf
pkill python
python /opt/pyload/pyLoadCore.py
while [ 1 ]; do
    /bin/bash
done
