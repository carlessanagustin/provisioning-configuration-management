# My Ansible Playbooks

This is my personal repo of ansible playbooks, enjoy!

# Usage:

## ansible-playbook command

* full line

        ansible-playbook install.yml -i hosts/all -vvv --tags=common,elk --skip-tags=nagios

* ask for sudo password

        ansible-playbook install.yml -i hosts/all -vvv -K

## Vagrant environment

@ Vagrantfile:

        config.vm.network "forwarded_port", guest: 80, host: 8080
        config.vm.network "forwarded_port", guest: 9200, host: 9200 # elasticsearch
        config.vm.network "forwarded_port", guest: 5601, host: 5601 # kibana 4
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible-playbooks/install.yml"
        end

