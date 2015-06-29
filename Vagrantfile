# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provision "shell", path: "scripts/install.sh"

  config.vm.provision :puppet, :options => "--debug --trace --verbose" do |puppet|
		puppet.manifests_path = "puppet/manifests"
		puppet.manifest_file  = "site.pp"
	end

  config.vm.provision "shell", inline: "shutdown -r now"

end
