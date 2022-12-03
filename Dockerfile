FROM debian:buster

# Install the packages we need. Avahi will be included
RUN apt-get update && apt-get install -y cups \
	&& rm -rf /var/lib/apt/lists/*

ADD https://download.brother.com/welcome/dlf103532/hll2310dpdrv-4.0.0-1.i386.deb /tmp/hll2310dpdrv-4.0.0-1.i386.deb
RUN dpkg --force-architecture -i /tmp/hll2310dpdrv-4.0.0-1.i386.deb \
	&& rm -rf /tmp/hll2310dpdrv-4.0.0-1.i386.deb

EXPOSE 631

# Baked-in config file changes
RUN sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
    sed -i 's/Browsing Off/Browsing On/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/>/<Location \/>\n  Allow All/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow All\n  Require user @SYSTEM/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin\/conf>/<Location \/admin\/conf>\n  Allow All/' /etc/cups/cupsd.conf && \
    echo "ServerAlias *" >> /etc/cups/cupsd.conf && \
    echo "DefaultEncryption Never" >> /etc/cups/cupsd.conf

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
