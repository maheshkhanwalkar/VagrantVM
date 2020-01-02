#!/usr/bin/env bash

# Update system + install required tools
apt-get update
apt install -y openjdk-8-jdk git

# Create hadoop user
adduser --disabled-password --gecos "" hadoop
sudo -i -u hadoop bash << EOF
cd /home/hadoop

# Extract hadoop
wget -nv https://www-us.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar xvf hadoop-3.2.1.tar.gz
mv hadoop-3.2.1/ hadoop/
mkdir -p hdfs/name
mkdir -p hdfs/data
rm hadoop-3.2.1.tar.gz

# Setup hadoop
git clone https://github.com/maheshkhanwalkar/Social
cp Social/config/* hadoop/etc/hadoop/
rm -rf Social

# Setup SSH
ssh-keygen -t rsa -N "" -f /home/hadoop/.ssh/id_rsa
cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
chmod 0600 /home/hadoop/.ssh/authorized_keys

# Update .bashrc
echo "export PATH=$PATH:/home/hadoop/hadoop/bin" >> /home/hadoop/.bashrc

EOF
