# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.boot_timeout = 60

  config.vm.define "n1" do |n1|
      n1.vm.hostname = "n1"
      n1.vm.network "private_network", ip: "172.20.20.10", virtualbox__intnet: true, auto_config: true

      n1.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true
      n1.vm.network "forwarded_port",  host: 8081, guest: 8500, auto_correct: true

      n1.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'v'
        ansible.host_key_checking = false
        ansible.tags = ['consul', 'boostrap', 'web_ui']
        #ansible.skip_tags = ''
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end

  config.vm.define "n2" do |n2|
      n2.vm.hostname = "n2"
      n2.vm.network "private_network", ip: "172.20.20.11", virtualbox__intnet: true, auto_config: true
      n2.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'v'
        ansible.host_key_checking = false
          ansible.tags = ['consul', 'client']
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end

  config.vm.define "n3" do |n3|
      n3.vm.hostname = "n3"
      n3.vm.network "private_network", ip: "172.20.20.12", virtualbox__intnet: true, auto_config: true
      n3.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'v'
        ansible.host_key_checking = false
        ansible.tags = ['consul', 'client']
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end
end