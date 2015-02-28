# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

NAME = ENV['VAGRANT_DOCKERHOST_NAME'] || 'dockerhost'
SUBNET = ENV['VAGRANT_PRIVATE_SUBNET'] || "192.168.200"
DOMAIN = ENV['VAGRANT_PRIVATE_DOMAIN'] || "example.org"
ADDRESS = ENV['VAGRANT_DOCKERHOST_ADDRESS'] || SUBNET + ".1"
MEMORY = ENV['VAGRANT_DOCKERHOST_MEMORY'] || 1024
CPUS =  ENV['VAGRANT_DOCKERHOST_CPUS'] || 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    
  config.vm.define NAME do |dockerhost|
      
      # Use a boot2docker clone that allows vagrant file syncing options
      dockerhost.vm.box = "dduportal/boot2docker"
  
      #sync ./ to /vagrant used by ./bootlocal.sh for exporting certificates
      dockerhost.vm.synced_folder ".", "/vagrant", type: "virtualbox"
   
      #networking
      dockerhost.vm.network :private_network, ip: ADDRESS
      dockerhost.vm.provider :virtualbox do |vb|
        vb.name = NAME
        vb.memory = MEMORY
        vb.cpus = CPUS        
      end      
      
      # add port forwards for any containers that need to be exposed
      #   note: 2375, 2376, and 2222 already defined by dduportal/boot2docker
  
      # un-comment for mongodb
      # dh.vm.network "forwarded_port", guest: 27017, host: 27017            
  end
 
end