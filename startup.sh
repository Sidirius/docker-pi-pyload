#!/bin/bash
mkdir /var/run/sshd
if [ ! -d /root/.pyload ]
then
    python /opt/pyload/pyLoadCore.py
fi
/usr/bin/supervisord -c /supervisord.conf

while [ 1 ]; do
    /bin/bash
done
