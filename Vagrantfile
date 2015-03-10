# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box       = "ubuntu/trusty64"
  config.vm.hostname  = 'rails-dev-box'

  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder "~/Projetos", "/vagrant", create: true, type: 'nfs'
  
  config.vm.network :forwarded_port, guest: 80, host: 80, auto_correct: true 	 # apache/nginx
  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true # rails
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true # mysql
  config.vm.network :forwarded_port, guest: 5432, host: 5432, auto_correct: true # postgresql

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end  
  
  # roda essa shell
  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
  # e depois a do rvm..
  config.vm.provision :shell, path: 'rvm.sh', privileged: false, keep_color: true
end
