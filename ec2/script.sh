#!/bin/bash
set -e  # Stop script if any command fails
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y nginx git

sudo systemctl start nginx
sudo systemctl enable nginx

cd /tmp
git clone https://github.com/sylviaprabudy/weather-dashboard.git

sudo rm -rf /var/www/html/*
sudo cp -r /tmp/weather-dashboard/* /var/www/html/

sudo systemctl restart nginx