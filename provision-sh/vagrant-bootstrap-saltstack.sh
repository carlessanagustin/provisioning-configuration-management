#!/usr/bin/env bash
apt-get update
apt-get -y upgrade

locale-gen UTF-8
#export LC_ALL=en_GB.UTF-8
#echo 'LC_ALL="en_GB.UTF-8"' >> /home/vagrant/.bash_profile
#echo 'LC_ALL="en_GB.UTF-8"' >> /etc/default/locale
#export LANG=en_GB.UTF-8
#echo 'LANG="en_GB.UTF-8"' >> /home/vagrant/.bash_profile
#echo 'LANG="en_GB.UTF-8"' >> /etc/default/locale

apt-get -y install git curl vim screen ssh tree lynx links links2 unzip

apt-get -y install python-pip python-dev build-essential python-virtualenv 

# Salt related...
apt-get -y install swig python-m2crypto libssl-dev dctrl-tools debconf-utils libjs-jquery libpgm-5.1-0 python-mako cython gcc

# ZeroMQ related...
apt-get -y install libtool pkg-config build-essential autoconf automake libzmq-dev

mkdir /home/vagrant/saltstack
cd /home/vagrant/saltstack
virtualenv env

source env/bin/activate
pip install salt
pip install apache-libcloud


#https://github.com/saltstack/halite
#$ git clone -b develop https://github.com/saltstack/salt.git
#$ cd salt && python setup.py install
#$ salt-master --version
#$ salt-master -l debug

# continue reading...
# http://vbyron.com/blog/infrastructure-management-saltstack-part-1-getting-started/
# http://vbyron.com/blog/infrastructure-management-saltstack-part-2-grains-states-pillar/
# http://vbyron.com/blog/infrastructure-management-saltstack-part-3-reactor-events/
# http://devopslogic.blogspot.com.es/2013/09/deploying-typical-lamp-application.html


# to continue...
# 1. then add these lines to Vagrantfile:
# config.vm.provision :shell, :path => "vagrant-bootstrap-saltstack.sh"
# config.vm.network "forwarded_port", guest: 80, host: 8085
# config.vm.network "forwarded_port", guest: 8000, host: 8086
# 2. then provision:
# $ vagrant up --provision
# or...
# $ vagrant reload --provision


