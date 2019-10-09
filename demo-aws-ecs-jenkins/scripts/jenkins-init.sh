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

# jenkins repository
sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo yum -y update
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

# install jenkins, docker, wget, unzip
sudo yum -y install java-1.8.0-openjdk-devel python36 jenkins docker wget unzip git

sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins

# install pip
sudo curl -O https://bootstrap.pypa.io/get-pip.py # wget -q -O - https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo rm -f get-pip.py

# install awscli
sudo pip install awscli

# remove java 7
sudo yum -y remove java

# download and install java 8
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
sudo tar -xzvf jdk-8u131-linux-x64.tar.gz
rm -rf jdk-8u131-linux-x64.tar.gz

# configure JAVA_HOME
sudo printf "\nalias cls='clear'\nexport JAVA_HOME=~/jdk1.8.0_131\nexport JRE_HOME=~/jdk1.8.0_131/jre\nexport PATH=$PATH:/usr/local/bin:~/jdk1.8.0_131/bin:/~/jdk1.8.0_131/jre/bin" >> ~/.bashrc
source ~/.bashrc

# install terraform
sudo wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
#sudo curl `https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip` -o `terraform_${TERRAFORM_VERSION}_linux_amd64.zip` \
&& sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
&& sudo rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# install packer
sudo wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
#sudo curl `https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip` -o `packer_${PACKER_VERSION}_linux_amd64.zip` \
&& sudo unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin \
&& sudo rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
sudo yum clean all

# start jenkins
sudo service docker start
sudo service jenkins start
sudo chkconfig jenkins on
sudo chkconfig docker on
