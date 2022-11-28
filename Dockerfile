FROM debian:bullseye

# Install the packages we need. Avahi will be included
RUN apt-get update && apt-get install -y cups 
&& rm -rf /var/lib/apt/lists/*

ADD https://download.brother.com/welcome/dlf103532/hll2310dpdrv-4.0.0-1.i386.deb /tmp/hll2310dpdrv-4.0.0-1.i386.deb
RUN dpkg --force-architecture -i /tmp/hll2310dpdrv-4.0.0-1.i386.deb \
&& rm -rf /tmp/hll2310dpdrv-4.0.0-1.i386.deb

RUN /usr/sbin/cupsctl --remote-admin \
&& /usr/sbin/cupsctl --share-printers \
&& /usr/sbin/cupsctl --remote-any

# This will use port 631
EXPOSE 631

# We want a mount for these
VOLUME /config

ADD run_cups.sh /run_cups.sh
RUN chmod +x /run_cups.sh
CMD ["/run_cups.sh"]
