#!/usr/bin/env bash

MYSQL_PASSWORD="vagrant"
PHPMYADMIN_PASSWORD="vagrant"

apt-get update
apt-get -y upgrade

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
# locale-gen en_US en_US.UTF-8 en_US en_US.UTF-8
dpkg-reconfigure locales

apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www

apt-get -y install git curl vim screen ssh tree unzip build-essential

a2enmod rewrite
a2enmod alias

usermod -a -G www-data vagrant

apt-get install -y php5-cli php5-curl php5-mcrypt php5-gd php5-mysql php5-gd libapache2-mod-php5 php5-json php-soap php5-dev libpcre3-dev gcc make
mv -i /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available/
php5enmod mcrypt

echo "mysql-server-5.5 mysql-server/root_password password $MYSQL_PASSWORD" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASSWORD" | debconf-set-selections

apt-get -y install mysql-client mysql-server

#echo "mysql-server mysql-server/root_password password $PHPMYADMIN_PASSWORD" | debconf-set-selections
#echo "mysql-server mysql-server/root_password_again password $PHPMYADMIN_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

apt-get -y install phpmyadmin

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

update-rc.d apache2 defaults
update-rc.d mysql defaults

apt-get -y autoremove

# to continue...
# 1. then add these lines to Vagrantfile:
# config.vm.provision :shell, :path => "vagrant-bootstrap-lamp.sh"
# config.vm.network "forwarded_port", host: 8080, guest: 80
# 2. then provision:
# $ vagrant up --provision
# or...
# $ vagrant reload --provision
