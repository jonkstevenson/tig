#!/bin/bash
# setup
# update and check for new packages
apt update
# install the pre-req for docker 
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# install repo key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#setup repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
## install docker
apt-get update && apt-get install docker-ce docker-ce-cli containerd.io -y 

## now setup telegraf on the local machine 
wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -

## install telegraf on local system
apt-get install telegraf


## copy new config file into place
cp ./install_tig/telegraf/telegraf.conf /etc/telegraf/telegraf.conf

## start running
systemctl daemon-reload
systemctl enable telegraf
systemctl start telegraf
systemctl restart telegraf
