#!/usr/bin/env bash

MAILNAME="zipi.com"
MAILTYPE="'Internet Site'"
PASS="nagios123"

# upgrading system
apt-get update
apt-get -y upgrade

# language settings
locale-gen UTF-8

# postfix unattended
debconf-set-selections <<< "postfix postfix/mailname string $MAILNAME"
debconf-set-selections <<< "postfix postfix/main_mailer_type string $MAILTYPE"
# nagios unattended
debconf-set-selections <<< "nagios3-cgi nagios3/adminpassword string $PASS"
debconf-set-selections <<< "nagios3-cgi nagios3/adminpassword-repeat string $PASS"
# nagios install
apt-get -y install nagios3 nagios-nrpe-plugin

# ONLY FOR VAGRANT BOX: setup working folder
service nagios3 stop
mkdir /vagrant/etc-nagios3
cp -rf /etc/nagios3/* /vagrant/etc-nagios3
rm -rf /etc/nagios3
ln -fs /vagrant/etc-nagios3 /etc/nagios3
service nagios3 start

# cgi configurations: http://technosophos.com/2010/01/13/nagios-fixing-error-could-not-stat-command-file-debian.html
chmod g+x /var/lib/nagios3/rw
usermod -a -G nagios www-data

# add to default runlevels
update-rc.d apache2 defaults
update-rc.d nagios3 defaults

# clean up
apt-get -y autoremove

## Open browser and go to...
## http://localhost:8080/nagios3/

# For nodes that need monitoring install: Nagios Remote Plugin Executor Server
# apt-get -y install nagios-nrpe-server
