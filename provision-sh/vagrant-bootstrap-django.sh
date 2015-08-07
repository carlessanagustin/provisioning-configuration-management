#!/usr/bin/env bash

# setup variables 
MYSQL_PASSWORD="django"
SYS_PASSWORD="vagrant"
DJANGO_DIR="/vagrant"

# Script start...
apt-get update
apt-get -y upgrade

apt-get -y install git curl vim screen ssh tree lynx links links2 unzip

locale-gen UTF-8

######################### apache2 #########################
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www

apt-get install -y libapache2-mod-wsgi

######################### PHP #########################
apt-get install -y php5-cli php5-curl php5-mcrypt php5-gd
mv -i /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available/
php5enmod mcrypt

######################### Python #########################
apt-get -y install python-pip python-dev build-essential python-virtualenv
## basic python code testing libraries
## apt-get -y install python-nose python-testtools python-unittest2 python-webunit python-coverage python-pytest python3-pytest python-tox python-mock pylint sloccount
## selenium on one machine - headless browsers: https://saucelabs.com/resources/selenium-jenkins#option1
## apt-get -y install python-selenium xvfb phantomjs firefox

######################### MySQL #########################

echo "mysql-server-5.5 mysql-server/root_password password $MYSQL_PASSWORD" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASSWORD" | debconf-set-selections

apt-get -y install mysql-client mysql-server sqlite3 
apt-get -y install python-mysqldb libmysqlclient-dev python-mysql.connector python3-mysql.connector

######################### phpmyadmin #########################

echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

echo "phpmyadmin phpmyadmin/app-password-confirm password $SYS_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/password-confirm password $SYS_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/setup-password password $SYS_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/database-type select mysql" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $SYS_PASSWORD" | debconf-set-selections

echo "dbconfig-common dbconfig-common/mysql/app-pass password $SYS_PASSWORD" | debconf-set-selections
echo "dbconfig-common dbconfig-common/mysql/app-pass password" | debconf-set-selections
echo "dbconfig-common dbconfig-common/password-confirm password $SYS_PASSWORD" | debconf-set-selections
echo "dbconfig-common dbconfig-common/app-password-confirm password $SYS_PASSWORD" | debconf-set-selections
echo "dbconfig-common dbconfig-common/app-password-confirm password $SYS_PASSWORD" | debconf-set-selections
echo "dbconfig-common dbconfig-common/password-confirm password $SYS_PASSWORD" | debconf-set-selections

apt-get -y install phpmyadmin

######################### Restart services #########################

service apache2 restart
service mysql restart

######################### Django environment #########################

mkdir ${DJANGO_DIR}/app
cd ${DJANGO_DIR}
virtualenv env
source env/bin/activate
pip install django
pip install MySQL-python
# auto pip ?
# pip install -r requirements.txt
deactivate

# start.bash
echo '#!/bin/bash' >> ${DJANGO_DIR}/app/start.bash
echo 'source ../env/bin/activate' >> ${DJANGO_DIR}/app/start.bash
echo 'python app/manage.py runserver 0.0.0.0:8000' >> ${DJANGO_DIR}/app/start.bash
echo 'deactivate' >> ${DJANGO_DIR}/app/start.bash
chmod 744 ${DJANGO_DIR}/app/start.bash

chown -Rf vagrant:vagrant ${DJANGO_DIR}/*

# auto git ?
#su - vagrant -c 'git config --global user.name "your name"'
#su - vagrant -c 'git config --global user.email here@your_email.com'


## to continue...
## 1. then add these lines to Vagrantfile:
# config.vm.provision :shell, :path => "vagrant-bootstrap-django.sh"
# config.vm.network "forwarded_port", guest: 80, host: 8080
# config.vm.network "forwarded_port", guest: 8000, host: 8081
## 2. then provision:
# $ vagrant up --provision
