# -*- mode: ruby -*-
# vi: set ft=ruby :

## List of ready boxes ######################
# zipi (ansible: base)
# zape (ansible: base)
# lamp (ansible: Linux, Apache, MySQL & PHP)
# iac (ansible: Infrastructure as Code)
# scripting (shell: file OR inline)
# n1 + n2 + n3 (consul testing)
#############################################

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.boot_timeout = 60
### START ###################################

## BOX: zipi ##############################################################
    
  config.vm.define "zipi" do |zipi|
    
    zipi.vm.host_name = "zipi"
    zipi.vm.box = "ubuntu/trusty64"
    zipi.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
      
    zipi.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]

    # host:port >> guest:port
    zipi.vm.network "forwarded_port", host: 3000, guest: 3000, auto_correct: true
#    zipi.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true
#    zipi.vm.network "forwarded_port",  host: 8081, guest: 3306, auto_correct: true
    zipi.vm.network "private_network", ip: "192.168.32.10", virtualbox__intnet: true, auto_config: true

    zipi.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision-ansible/install-all.yml"
      ansible.verbose = 'v'
      ansible.host_key_checking = false
      ansible.sudo = true
        
        ansible.tags = ['testingjs']
      #ansible.skip_tags = ''
      
      ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          vagrant_enable: true
          }
    
      # STATIC INVENTORY
      #ansible.inventory_path = "provision-ansible/hosts/all"
      #ansible.limit = 'vagrant'
        
      # AUTO-GENERATED INVENTORY
      ansible.groups = {
        "group1" => ["zipi"],
        "all_groups:children" => ["group1"],
        #"group1:vars" => { "vagrant_enable" => true }
      }
    end
  end

## BOX: zape ##############################################################
    
  config.vm.define "zape" do |zape|
    
    zape.vm.host_name = "zape"
    zape.vm.box = "ubuntu/trusty64"
    zape.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
      
    zape.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]
        
    # host:port >> guest:port
#    zape.vm.network "forwarded_port", host: 8082, guest: 80, auto_correct: true
#    zape.vm.network "forwarded_port",  host: 8083, guest: 8080, auto_correct: true
    zape.vm.network "private_network", ip: "192.168.32.11", virtualbox__intnet: true, auto_config: true

    zape.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision-ansible/install-all.yml"
      ansible.verbose = 'v'
      ansible.host_key_checking = false
      ansible.sudo = true
        
      ansible.tags = ['base']
      #ansible.skip_tags = ''
      
      ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          vagrant_enable: true
          }
    
      # STATIC INVENTORY
      #ansible.inventory_path = "provision-ansible/hosts/all"
      #ansible.limit = 'vagrant'
        
      # AUTO-GENERATED INVENTORY
      ansible.groups = {
        "group1" => ["zape"],
        "all_groups:children" => ["group1"],
        #"group1:vars" => { "vagrant_enable" => true }
      }
    end
  end
    
## BOX: lamp ###################################
  config.vm.define "lamp" do |lamp|
    
    lamp.vm.host_name = "lamp"
    lamp.vm.box = "ubuntu/trusty64"
    lamp.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
      
    lamp.vm.synced_folder ".", "/vagrant",
      owner: "vagrant",
      group: "vagrant",
#      owner: "www-data",
#      group: "www-data",
      mount_options: ["dmode=775,fmode=664"]

    # host:port >> guest:port
    lamp.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true
    lamp.vm.network "forwarded_port",  host: 8081, guest: 3306, auto_correct: true
    lamp.vm.network "private_network", ip: "192.168.32.12", virtualbox__intnet: true, auto_config: true
      
    lamp.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision-ansible/install-all.yml"
      ansible.verbose = 'v'
      ansible.host_key_checking = false
      ansible.sudo = true
        
      ansible.tags = ['lamp', 'phpmyadmin']
      #ansible.skip_tags = ''
      
      ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          vagrant_enable: true,
          localhost_only: true
          }
    
      # STATIC INVENTORY
      #ansible.inventory_path = "provision-ansible/hosts/all"
      #ansible.limit = 'vagrant'
        
      # AUTO-GENERATED INVENTORY
      ansible.groups = {
        "group1" => ["lamp"],
        "all_groups:children" => ["group1"],
        #"group1:vars" => { "vagrant_enable" => true }
      }
    end
  end

## BOX: iac ###################################
  config.vm.define "iac" do |iac|
    
    iac.vm.host_name = "iac"
    iac.vm.box = "ubuntu/trusty64"
    iac.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
      
    iac.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]
    
    # host:port >> guest:port
    iac.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true
    iac.vm.network "forwarded_port",  host: 8081, guest: 8080, auto_correct: true
    iac.vm.network "private_network", ip: "192.168.32.13", virtualbox__intnet: true, auto_config: true

    iac.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision-ansible/install-all.yml"
      ansible.verbose = 'v'
      ansible.host_key_checking = false
      ansible.sudo = true
        
      ansible.tags = ['base', 'ansible']
      #ansible.skip_tags = ''
      
      ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          vagrant_enable: true
          }
    
      # STATIC INVENTORY
      #ansible.inventory_path = "provision-ansible/hosts/all"
      #ansible.limit = 'vagrant'
        
      # AUTO-GENERATED INVENTORY
      ansible.groups = {
        "group1" => ["iac"],
        "all_groups:children" => ["group1"],
        #"group1:vars" => { "vagrant_enable" => true }
      }
    end
  end

## BOX: scripting ###################################
  config.vm.define "scripting" do |scripting|
    
    scripting.vm.host_name = "scripting"
    scripting.vm.box = "ubuntu/trusty64"
    scripting.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
      
    scripting.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=664"]
    
    # host:port >> guest:port
    scripting.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true
    scripting.vm.network "forwarded_port",  host: 8081, guest: 8080, auto_correct: true
    scripting.vm.network "private_network", ip: "192.168.32.14", virtualbox__intnet: true, auto_config: true
    

    #scripting.vm.provision :shell, :path => "provision-sh/vagrant-bootstrap-opennms.sh"
    scripting.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get -y upgrade"
  end

## BOX: n1 + n2 + n3 ###################################
  config.vm.define "n1" do |n1|
      n1.vm.hostname = "n1"
      n1.vm.box = "ubuntu/trusty64"
      n1.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end

      n1.vm.network "private_network", ip: "172.20.20.10", virtualbox__intnet: true, auto_config: true
      n1.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'vvvv'
        ansible.host_key_checking = false
        ansible.tags = ['consul', 'server']
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end

  config.vm.define "n2" do |n2|
      n2.vm.hostname = "n2"
      n2.vm.box = "ubuntu/trusty64"
      n2.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end

      n2.vm.network "private_network", ip: "172.20.20.11", virtualbox__intnet: true, auto_config: true
      n2.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'vvvv'
        ansible.host_key_checking = false
        ansible.tags = ['consul', 'client']
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end

  config.vm.define "n3" do |n3|
      n3.vm.hostname = "n3"
      n3.vm.box = "ubuntu/trusty64"
      n3.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end

      n3.vm.network "private_network", ip: "172.20.20.12", virtualbox__intnet: true, auto_config: true
      n3.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision-ansible/install-vagrant.yml"
        ansible.verbose = 'vvvv'
        ansible.host_key_checking = false
        ansible.tags = ['consul', 'client']
        ansible.extra_vars = {
          vagrant_enable: true,
        }
      end
  end
    
### END ###################################
end

