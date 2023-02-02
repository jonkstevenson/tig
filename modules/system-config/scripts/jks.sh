#!/bin/bash
# setup
# update and check for new packages

## now setup telegraf on the local machine 
cat <<EOF | sudo tee /etc/apt/sources.list.d/influxdata.list
deb https://repos.influxdata.com/ubuntu $(lsb_release -cs) stable
EOF
curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
apt update
apt install telegraf -y

## start running
systemctl daemon-reload
systemctl enable telegraf

