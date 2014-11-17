#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu-14.04-lxc"
    config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    config.vm.synced_folder "files", "/vagrant/files", type: "rsync"
    config.librarian_puppet.puppetfile_dir = "puppet"
    config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
    config.vm.provision :shell, :path => "shell/main.sh"

    config.vm.define "jenkins-slave-docker" do |dockerlxc|
        dockerlxc.vm.network "private_network", ip: "33.33.33.50"
        dockerlxc.vm.provision "puppet" do |puppet|

        end
    end
end
