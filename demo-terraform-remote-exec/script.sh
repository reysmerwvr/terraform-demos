#!/bin/bash
# sleep until instance is ready
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done
sudo su -l ec2-user
# install nginx
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install epel-release
sudo yum-config-manager --enable epel
sudo yum -y install nginx
# make sure nginx is started
sudo service nginx start
sudo chkconfig nginx on