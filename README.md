vagrant dockerhost
==================

This is a sample of a Vagrant Docker Provider configuration.  It is based on ideas and samples from a [comment](http://www.reddit.com/r/docker/comments/2osgl7/vagrant_vs_boot2docker/cmqvlhy) by reddit user [artsmeis](http://www.reddit.com/user/artsemis).  It uses [dduportal/boot2docker-vagrant-box](https://github.com/dduportal/boot2docker-vagrant-box) forked from [yungsang/boot2docker](https://github.com/YungSang/boot2docker-vagrant-box), it [appears](https://github.com/YungSang/boot2docker-vagrant-box/issues/22) that yungsang/boot2docker is no longer maintained.

Prerequisites
-------------
 * Mac OS X
 * [Vagrant](https://www.vagrantup.com/)
 * [Virtualbox](https://www.virtualbox.org/)
 * [boot2docker](https://github.com/boot2docker/osx-installer/releases)

Sample Usage
------------


using $HOME/projects/vagrant-dockerhost as the install location

    $ cd $HOME/projects/vagrant-dockerhost
    $ ./dockerenv
    $ vagrant up
    Bringing machine 'dockerhost' up with 'virtualbox' provider...

You should have some certs in the `$HOME/projects/vagrant-dockerhost/tls` directory now.

    $ docker ps
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

No container yet, but proves that the `docker` command can talk to the Virtualbox hosted docker.

Environment Variables
---------------------

I recommend setting environment variables for the location of your docker host Vagrantfile.   

sample contents of `~/.bash_profile` 
replace `$HOME/projects/vagrant-dockerhost` with actual location.

    export VAGRANT_DOCKERHOST="$HOME/projects/vagrant-dockerhost"
    export VAGRANT_DOCKERHOST_VAGRANTFILE="$VAGRANT_DOCKERHOST/Vagrantfile"    
    export VAGRANT_DOCKERHOST_NAME="dockerhost"
    source "$VAGRANT_DOCKERHOST/dockerenv"


Sample Vagrantfile use by another project
-----------------------------------------

	# -*- mode: ruby -*-
	# vi: set ft=ruby :

	VAGRANT_DOCKERHOST_NAME = ENV['VAGRANT_DOCKERHOST_NAME'] || 'dockerhost'
	VAGRANT_DOCKERHOST_VAGRANTFILE = ENV['VAGRANT_DOCKERHOST_VAGRANTFILE'] || './VagrantfileHost'
	VAGRANTFILE_API_VERSION = "2"
	ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	  config.vm.synced_folder ".", "/vagrant", disabled: true

	  config.vm.define "mongodb" do |mdb|
	  
	    mdb.vm.provider "docker" do |d|
	      d.name = "mongodb"
	      d.image = "mongo:3.0.0"
	      d.ports = ["27017:27017"]
	      d.has_ssh = false
	      d.vagrant_machine = VAGRANT_DOCKERHOST_NAME
	      d.vagrant_vagrantfile = VAGRANT_DOCKERHOST_VAGRANTFILE
	    end
	  
	  end
	  
	end

### sample usage

	$ vagrant up
	Bringing machine 'mongodb' up with 'docker' provider...

	$ docker ps
	CONTAINER ID        IMAGE               COMMAND                CREATED              STATUS              PORTS                      NAMES
	b13744b4bb9d        mongo:3.0.0         "/entrypoint.sh mong   About a minute ago   Up About a minute   0.0.0.0:27017->27017/tcp   mongodb

Related Information
-------------------
[Docker Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet)
