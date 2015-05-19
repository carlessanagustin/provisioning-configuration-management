# My Ansible Playbooks

This is my personal repo of ansible playbooks, enjoy!

# Usage:

## Vagrant instructions

1. change: install.yml (roles + vars)
2. run: vagrant up --provision

## For non-Vagrant

* run: ansible-playbook install.yml -i hosts/all -vvvv --skip-tags=vagrant

--  by carlessanagustin.com --
