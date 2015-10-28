# My provisioning scripts

**Use with precaution! This repository is in constant development.**

This is my personal repository of installation shell scripts and Ansible playbooks. I use them for teaching purposes as DevOps Coach.

**Please fork, use and comment this repo ;)**

## 1. [Ansible](http://www.ansible.com/) Playbooks

[Ansible Cheat Sheet](https://gist.github.com/carlessanagustin/f935fac7b61661b31d74)

### Setup local Ansible environment

1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)
3. Install [Python](https://www.python.org/)
4. Clone this repository into a local folder

    	$ git clone https://github.com/carlessanagustin/provisioning-configuration-management.git ~/provisioning

5. Enter into new folder

    	$ cd ~/provisioning
        
6. Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html) and its requirements

        $ pip install -r requirements
        
> NOTE: You can fully install Ansible environment into the system or use a virtualenv for that purpose.

### 1.1. Testing in local Vagrant: Instructions

1. Enter into folder

    	$ cd ~/provisioning

2. Rename Vagrantfile-ansible file to Vagrantfile

		$ cp Vagrantfile-ansible Vagrantfile
    
3. Edit Vagrantfile

		$ vim Vagrantfile
    
4. Customize Vagrantfile

        zipi.vm.box = "ubuntu/trusty64"
        ansible.tags = ['base', 'ansible']
        ansible.playbook = "provision-ansible/install-all.yml"
        ansible.extra_vars = {
            ansible_ssh_user: 'vagrant',
            vagrant_enable: true
        }

> For more vm.box options: https://atlas.hashicorp.com/boxes/search

5. Edit Ansible Playbook and customize it

        $ vim provision-ansible/install-all.yml

6. Start vagrant

        $ vagrant up --provision

### 1.2. Provisioning to any IP: Instructions

1. Enter into folder

    	$ cd ~/provisioning/provision-ansible
    
2. Edit Ansible [Playbook](http://docs.ansible.com/ansible/playbooks.html) and customize it

        $ vim install-all.yml

3. Edit [Inventory](http://docs.ansible.com/ansible/intro_inventory.html) file and customize it

        $ vim hosts/all
        
4. List tasks and hosts the Playbook will affect

        $ ansible-playbook install-all.yml -i hosts/all --list-tasks --list-hosts

5. If you are happy with step 6 then provision your machine(s)

        $ ansible-playbook install-all.yml -i hosts/all -vvvv

*--  by http://www.carlessanagustin.com 2015 --*

---

## 2. (deprecated) Shell scripts (deprecated)

### Testing in local Vagrant: Instructions

1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)
3. Clone this repository into a local folder

    	$ git clone https://github.com/carlessanagustin/provisioning-configuration-management.git
    
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

*--  by http://www.carlessanagustin.com 2015 --*
