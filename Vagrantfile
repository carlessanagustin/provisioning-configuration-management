# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
 
  config.vm.provider "virtualbox"
  config.vm.boot_timeout = 60
 
  config.vm.define "zipi" do |zipi|
    
    zipi.vm.host_name = "zipi"
    zipi.vm.box = "ubuntu/trusty64"
      
    zipi.vm.synced_folder ".", "/vagrant",
      owner: "vagrant",
      group: "vagrant",
      mount_options: ["dmode=775,fmode=664"]
    
    zipi.vm.network "private_network",
      ip: "192.168.32.10",
      virtualbox__intnet: true,
      auto_config: true
      
    zipi.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    #zipi.vm.network "forwarded_port", guest: 8080, host: 8081, auto_correct: true

    zipi.vm.provision "ansible" do |ansible|
      ansible.playbook = "install.yml"
    end

  end
    
end
