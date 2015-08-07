#!/usr/bin/env bash

# add ansible repo
apt-add-repository -y ppa:ansible/ansible
# upgrading system
apt-get update
apt-get -y upgrade

# packages: basic
apt-get -y install git curl vim screen ssh tree lynx links links2 unzip
# packages: python
apt-get -y install python-pip python-dev build-essential python-virtualenv

# local configuration
locale-gen UTF-8

# packages: ansible
apt-get -y install software-properties-common
apt-get -y install ansible
pip install http://github.com/diyan/pywinrm/archive/master.zip#egg=pywinrm

# to continue...
# 1. then add these lines to Vagrantfile:
# config.vm.provision :shell, :path => "vagrant-bootstrap-ansible.sh"
# config.vm.network "forwarded_port", guest: 8010, host: 8081
# 2. then provision:
# $ vagrant up --provision
