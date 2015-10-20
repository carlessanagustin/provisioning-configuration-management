# Selenium hub (server) + node (client)

following instructions from:
http://pietervogelaar.nl/ubuntu-14-04-install-selenium-as-service-headless

## Ansible run command

ansible-playbook install-selenium.yml -i hosts/all -k --skip-tags=oracle,local -vvv

## Selenium Standalone Server

selenium-server-standalone-2.48.2.jar - http://goo.gl/PJUZfa
