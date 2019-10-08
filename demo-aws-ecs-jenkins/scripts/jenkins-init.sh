#!/bin/bash
sudo su -l ec2-user
sudo yum -y update
sudo yum -y upgrade
# volume setup
vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi
mkdir -p /var/lib/jenkins
echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/jenkins

# install dependencies
sudo yum -y install python36 java-1.8.0-openjdk-devel

# jenkins repository
sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo yum -y update
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

# install jenkins
sudo yum -y install jenkins docker wget unzip

sudo usermod -a -G docker ec2-user

# install pip
sudo curl -O https://bootstrap.pypa.io/get-pip.py # wget -q -O - https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo rm -f get-pip.py

# install awscli
sudo pip install awscli

# install terraform
#wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_$${TERRAFORM_VERSION}_linux_amd64.zip
sudo curl "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
&& sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& sudo rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install packer
#wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
sudo curl "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" -o "packer_${PACKER_VERSION}_linux_amd64.zip" \
&& sudo unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& sudo rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
cd /usr/local/bin
sudo yum clean all

# start jenkins
sudo service docker start
sudo service jenkins start
sudo chkconfig jenkins on
sudo chkconfig docker on
