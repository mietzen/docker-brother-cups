#!/bin/bash -ex

if [ $(grep -ci $CUPSADMIN /etc/shadow) -eq 0 ]; then
        useradd -r -G lpadmin -M $CUPSADMIN
    echo $CUPSADMIN:$CUPSPASSWORD | chpasswd
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
    dpkg-reconfigure --frontend noninteractive tzdata
fi

exec /usr/sbin/cupsd -f