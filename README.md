# My provisioning scripts

**Use with precaution! This repository is in constant development. I DO NOT ASSUME ANY MISUSE.**

This is my personal repository of installation shell scripts and ansible playbooks. I use them for teaching purposes as DevOps Coach.

**Please fork, use and comment this repo ;)**

## 1. [Ansible](http://www.ansible.com/) Playbooks

### Folder contents

* Vagrantfile-ansible: Vagrantfile ready to run 1 Ubuntu 14 (ubuntu/trusty64)
* provision-ansible: Ansible [Playbooks](http://docs.ansible.com/ansible/playbooks.html) and [Roles](http://docs.ansible.com/ansible/playbooks_roles.html)
    * roles
    * ├── ansible
    * ├── base
    * ├── clean
    * ├── docker
    * ├── elasticsearch
    * ├── hyperv
    * ├── kibana
    * ├── logstash
    * ├── nagios
    * └── samba

### Instructions

1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)
3. Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html)
4. Clone this repository into a local folder

    	$ git clone ....
    
5. Rename Vagrantfile-ansible file to Vagrantfile

        $ cp Vagrantfile-ansible Vagrantfile
    
6. Edit Vagrantfile

        $ vim Vagrantfile
    
7. Customize it

        zipi.vm.box = "ubuntu/trusty64"
        ansible.tags = ['base', 'ansible']
        ansible.playbook = "provision-ansible/install.yml"
        ansible.extra_vars = {
            ansible_ssh_user: 'vagrant',
            vagrant_enable: true
        }

> For more vm.box options: https://atlas.hashicorp.com/boxes/search

8. Edit provision-ansible/install.yml and customize it

        $ vim provision-ansible/install.yml

9. Start vagrant

        $ vagrant up --provision

## 2. Shell scripts
### Folder contents

* Vagrantfile_01-sh: Vagrantfile ready to run 1 Ubuntu 14 (ubuntu/trusty64)
* Vagrantfile_02-sh: Vagrantfile ready to run 2 Ubuntu 14 (ubuntu/trusty64)
* provision-sh: Installation shell scripts...
    * **vagrant-bootstrap-ansible.sh**: python, ansible.
    * **vagrant-bootstrap-buildbot.sh**: python, buildbot, buildbot-slave.
    * **vagrant-bootstrap-django.sh**: apache, php, mysql, phpmyadmin, python & django.
    * **vagrant-bootstrap-jenkins.sh**: jenkins, nginx.
    * **vagrant-bootstrap-jenkins-node.sh**: java
    * **vagrant-bootstrap-lamp.sh**: apache, php, mysql, phpmyadmin.
    * **vagrant-bootstrap-nagios.sh**: apache, php, postfix, nagios3, nagios-nrpe-plugin.
    * **vagrant-bootstrap-saltstack.sh**: (in development)
    * **vagrant-bootstrap-up.sh**: Debian apt-get update + upgrade ONLY

### Instructions

1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)
3. Clone this repository into a local folder

    	$ git clone ....
    
4. Rename any of the Vagrantfile_XX-sh files to Vagrantfile

        $ cp Vagrantfile_01-sh Vagrantfile
    
5. Edit Vagrantfile

        $ vim Vagrantfile
    
6. Customize it

        ....vm.box = "ubuntu/trusty64"
        ....vm.provision :shell, :path => "provision-sh/vagrant-bootstrap-XXX.sh"

> For more vm.box options: https://atlas.hashicorp.com/boxes/search

7. Edit provision-sh/vagrant-bootstrap-XXX.sh and customize it

        $ vim provision-sh/vagrant-bootstrap-XXX.sh

8. Start vagrant

        $ vagrant up --provision


*--  by carlessanagustin.com 2015 --*
