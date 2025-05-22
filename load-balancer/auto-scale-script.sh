#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y 
sudo apt-get install -y nginx git
sudo systemctl start nginx
sudo systemctl enable nginx 
sudo rm -rf /var/www/html/*
cd /tmp
git clone https://github.com/sylviaprabudy/weather-dashboard.git
sudo cp -r /tmp/weather-dashboard/* /var/www/html/
sudo systemctl restart nginx