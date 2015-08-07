#!/usr/bin/env bash
apt-get update
apt-get -y upgrade

apt-get -y install git curl vim screen ssh tree lynx links links2 unzip

apt-get -y install python-pip python-dev build-essential python-virtualenv sqlite3 libssl-dev libffi-dev libapr1 libaprutil1 libjs-jquery libjs-sphinxdoc libjs-underscore

locale-gen UTF-8

mkdir /home/vagrant/buildbot
cd /home/vagrant/buildbot
virtualenv env

source env/bin/activate
pip install sqlalchemy==0.7.10
pip install pyopenssl
pip install buildbot
pip install buildbot-slave

buildbot create-master -r bbmaster
cp bbmaster/master.cfg.sample bbmaster/master.cfg
buildslave create-slave -r bbslave localhost:9989 example-slave pass
deactivate

################# help files
# check.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/check.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/check.bash
echo 'buildbot checkconfig bbmaster' >> /home/vagrant/buildbot/check.bash
echo 'deactivate' >> /home/vagrant/buildbot/check.bash
# log.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/log.bash
echo 'tail -f bbmaster/twistd.log' >> /home/vagrant/buildbot/log.bash
# reload.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/reload.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/reload.bash
echo 'buildbot stop bbmaster' >> /home/vagrant/buildbot/reload.bash
echo 'buildbot start bbmaster' >> /home/vagrant/buildbot/reload.bash
echo 'deactivate' >> /home/vagrant/buildbot/reload.bash
# start.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/start.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/start.bash
echo 'buildbot start bbmaster' >> /home/vagrant/buildbot/start.bash
echo 'deactivate' >> /home/vagrant/buildbot/start.bash
# stop.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/stop.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/stop.bash
echo 'buildbot stop bbmaster' >> /home/vagrant/buildbot/stop.bash
echo 'deactivate' >> /home/vagrant/buildbot/stop.bash
# start-all.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/start-all.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/start-all.bash
echo 'buildbot stop bbmaster' >> /home/vagrant/buildbot/start-all.bash
echo 'buildslave stop bbslave' >> /home/vagrant/buildbot/start-all.bash
echo 'buildbot start bbmaster' >> /home/vagrant/buildbot/start-all.bash
echo 'buildslave start bbslave' >> /home/vagrant/buildbot/start-all.bash
echo 'deactivate' >> /home/vagrant/buildbot/start-all.bash
# stop-all.bash
echo '#!/bin/bash' >> /home/vagrant/buildbot/stop-all.bash
echo 'source env/bin/activate' >> /home/vagrant/buildbot/stop-all.bash
echo 'buildbot stop bbmaster' >> /home/vagrant/buildbot/stop-all.bash
echo 'buildslave stop bbslave' >> /home/vagrant/buildbot/stop-all.bash
echo 'deactivate' >> /home/vagrant/buildbot/stop-all.bash

chmod 764 /home/vagrant/buildbot/*.bash
################# help files

# simple...
#buildbot start bbmaster
#buildslave start bbslave

chown -Rf vagrant:vagrant /home/vagrant/.bash_profile
chown -Rf vagrant:vagrant /home/vagrant/.viminfo
chown -Rf vagrant:vagrant /home/vagrant/buildbot

# to continue...
# 1. then add these lines to Vagrantfile:
# config.vm.provision :shell, :path => "vagrant-bootstrap-buildbot.sh"
# config.vm.network "forwarded_port", guest: 8010, host: 8081
# 2. then provision:
# $ vagrant up --provision
