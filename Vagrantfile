# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_DOCKERHOST_NAME = ENV.fetch('VAGRANT_DOCKERHOST_NAME') { 'dockerhost' }

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    
  # Use a boot2docker clone that allows vagrant file syncing options
  config.vm.box = "dduportal/boot2docker"
  
  #sync ./ to /vagrant used by ./bootlocal.sh for exporting certificates
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    
  config.vm.define VAGRANT_DOCKERHOST_NAME do |dh|
      # add port forwards for any containers that need to be exposed
      #   note: 2375, 2376, and 2222 already defined by dduportal/boot2docker
  
      # un-comment for mongodb
      # dh.vm.network "forwarded_port", guest: 27017, host: 27017            
  end
 
end