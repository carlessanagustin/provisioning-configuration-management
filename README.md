# My Ansible Playbooks

This is my personal repo of ansible playbooks, enjoy!

## Usage: Vagrant instructions

1. git clone
2. change: provision/install.yml
3. run: vagrant up --provision

## Usage: Non-Vagrant instructions

1. change: provision/roles
2. run: provision/ansible-playbook install.yml -i hosts/all -vvvv --skip-tags=vagrant

--  by carlessanagustin.com --
