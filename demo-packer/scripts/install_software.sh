#!/bin/bash
sudo su -l ec2-user
sudo yum -y update
sudo yum -y install epel-release
sudo yum-config-manager --enable epel
sudo yum -y install nginx docker.io vim lvm2
sudo service nginx start
sudo chkconfig nginx on
