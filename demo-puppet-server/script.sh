#!/bin/bash
sudo su -l
# Update dependencies
sudo yum -y update
sudo yum -y upgrade
###### Install Puppet on the Puppet Master Server ######
sudo yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
sudo yum -y install puppetserver
# Change the Memory Allocation
sudo sed -i 's/-Xms2g -Xmx2g/-Xms512m -Xmx512m/g' /etc/sysconfig/puppetserver
# Set the Puppet server to automatically start on boot and turn it on
sudo chkconfig puppetserver on
sudo service puppetserver start
###### Install Puppet on Agent Nodes ######
#sudo yum -y install puppet
# Set Puppet will start after boot and turn it on.
#sudo chkconfig puppet on
#sudo service puppet start
###### Install Foreman ######
sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install https://yum.theforeman.org/releases/1.23/el7/x86_64/foreman-release.rpm
sudo yum -y install foreman-installer
# Running the installer
sudo foreman-installer
sudo puppet agent --test