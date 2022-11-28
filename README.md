# Configuration

## Volumes:
* `/config`: where the persistent printer configs will be stored

## Variables:
* `CUPSADMIN`: the CUPS admin user you want created
* `CUPSPASSWORD`: the password for the CUPS admin user

## Ports:
* `631`: the TCP port for CUPS must be exposed

# Using
CUPS will be configurable at http://<IP>:631 using the CUPSADMIN/CUPSPASSWORD when you do something administrative.
