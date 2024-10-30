## As user

#### Pre-requisute:

A linux based computer with docker installed.

### Installation

1. Download file
https://raw.githubusercontent.com/hsrai/frappe_docker/refs/heads/education/rai/erpnextPlusApps.yml
1. Line number 68 list all available apps, and all will be installed. If you
don't like to install any app, say, foo, then remove "--install foo".
1. Repeat above step for any other app. Replace foo with payments or
helpdesk.
1. This file will create site with name `frontend`. Replace it with any name
you like at line number 68 and 100.
1. Issue command: `docker compose -f erpnextPlusApps.yml up -d`
1. Wait for about 5 to 10 minutes.
1. Site will be available at http://ipAddressofYourServer:8080
1. Default credentials are:- user:administrator password:admin