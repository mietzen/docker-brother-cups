#!/bin/sh -ex

if [ $(grep -ci $CUPSADMIN /etc/shadow) -eq 0 ]; then
    useradd -r -G lpadmin -M $CUPSADMIN 
fi
echo $CUPSADMIN:$CUPSPASSWORD | chpasswd

mkdir -p /config
if [ ! -f /config/printers.conf ]; then
    ln -s /config/printers.conf /etc/cups/printers.conf
    chmod 777 /config/printers.conf
fi

exec /usr/sbin/cupsd -f
