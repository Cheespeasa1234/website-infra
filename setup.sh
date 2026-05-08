#!/bin/bash

# dont let steam delete user directory
set -euo pipefail

# update
apt update
apt upgrade -y

# clone all the things
mkdir /www
git clone https://github.com/Cheespeasa1234/natelevison.com.git /www/natelevison.com
git clone https://github.com/Cheespeasa1234/static.natelevison.com.git /www/static.natelevison.com

mkdir /tmp/website-infra
git clone https://github.com/Cheespeasa1234/website-infra.git /tmp/website-infra

# setup firewall
ufw allow OpenSSH
ufw enable

# setup nginx
apt install nginx -y
ufw allow 'Nginx Full'



# setup node
apt install nodejs -y
apt install npm -y