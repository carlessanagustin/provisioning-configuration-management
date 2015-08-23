#!/usr/bin/env bash

# following:
# http://www.opennms.org/wiki/Installation:Debian#Configure_APT

cat << EOF | sudo tee /etc/apt/sources.list.d/opennms.list
deb http://debian.opennms.org stable main
deb-src http://debian.opennms.org stable main
EOF

wget -O - http://debian.opennms.org/OPENNMS-GPG-KEY | apt-key add -

apt-get update
apt-get -y upgrade

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
# locale-gen en_US en_US.UTF-8 en_US en_US.UTF-8
dpkg-reconfigure locales

apt-get -y install git curl vim screen ssh tree unzip build-essential
apt-get -y install postgresql openjdk-7-jre openjdk-7-jdk

# debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
# debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
# apt-get -y install postfix

echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
apt-get -y install postfix

apt-get -y install opennms

apt-get -y autoremove
