# My Ansible Playbooks

This is my personal repo of ansible playbooks, enjoy!

NOT TESTED, PLEASE BE CAREFUL.

# Usage:

## Vagrant instructions

* change install.yml as needed
* run: vagrant up --provision

## ansible-playbook command

* run: ansible-playbook install.yml -i hosts/all -vvv --tags=common --skip-tags=nagios

--  by carlessanagustin.com --
