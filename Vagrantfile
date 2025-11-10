# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

servers=[
  {
    :hostname => "servera",
    :ip => "192.168.200.10",
    :box => "generic/rhel9",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "serverb",
    :ip => "192.168.200.11",
    :box => "generic/rhel9",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "serverc",
    :ip => "192.168.200.12",
    :box => "generic/rhel9",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "serverd",
    :ip => "192.168.200.13",
    :box => "generic/rhel9",
    :ram => 2048,
    :cpu => 2
  },
  {
    :hostname => "workstation",
    :ip => "192.168.200.14",
    :box => "generic/rhel9",
    :ram => 2048,
    :cpu => 2
  },

]


$script = <<-SCRIPT
echo Adding IPS in hosts
echo "192.168.200.10 servera" | sudo tee -a /etc/hosts
echo "192.168.200.11 serverb" | sudo tee -a /etc/hosts
echo "192.168.200.12 serverc" | sudo tee -a /etc/hosts
echo "192.168.200.13 serverd" | sudo tee -a /etc/hosts
echo "192.168.200.14 workstation utility" | sudo tee -a /etc/hosts
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure(2) do |config|
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip]
            node.vm.box_version = "4.0.0"
            node.vm.provider "virtualbox" do |vb|
              vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
            end
        node.vm.provision "shell", inline: $script
        end
        config.vm.provision "shell" do |s|
          ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
          s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
          SHELL
        end
    end
end
