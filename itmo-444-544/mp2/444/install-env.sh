#!/bin/bash

# Install dependecies here:
sudo apt install -y nginx 
sudo systemctl enable --now nginx
##############################################################################
# Install Node JS
# https://github.com/nodesource/distributions#installation-instructions-deb
##############################################################################
curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install -y nodejs
node -v



# Run NPM to install the NPM Node packages needed for the code
# You will start this NodeJS script by executing the command: node app.js
# from the directory where app.js is located. The program `pm2` can be
# used to auto start NodeJS applications (as they don't have a normal
# systemd service handler).
# <https://pm2.keymetrics.io/docs/usage/quick-start/>. This will require
# the install of PM2 via npm as well.
cd /home/ubuntu
sudo -u ubuntu npm install @aws-sdk/client-s3 @aws-sdk/client-sns @aws-sdk/client-rds @aws-sdk/client-secrets-manager @aws-sdk/client-dynamodb express multer multer-s3 mysql2
sudo npm install pm2 -g

# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "hajek.git" to be your private repo name (hawk ID) #
####################################################################
sudo -u ubuntu git clone git@github.com:illinoistech-itm/jhajek.git

#######################################################################################
# Copy over your default Nginx configuration file to provide routes for /db /gallery and /upload
sudo cp /home/ubuntu/jhajek/itmo-444-544/mp2/444/default /etc/nginx/sites-available/default
# Reload the nginx config with your changes
sudo systemctl daemon-reload
sudo systemctl restart nginx

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
cd /home/ubuntu/jhajek/itmo-444-544/mp2/444/

sudo pm2 start app.js

# Delete the RSA private key once setup is finished
rm /home/ubuntu/.ssh/id_ed25519

