#!/bin/bash
#cleanup previous config
vagrant destroy --force
for i in {a,b,c,d}; do
ssh-keygen -f /home/"$USER"/.ssh/known_hosts -R server"$i"
done
ssh-keygen -f /home/"$USER"/.ssh/known_hosts -R workstation
sudo sed -i /VAGRANT/d /etc/hosts

# generate new infra
vagrant up
cd playbook
ansible-playbook playbook.yaml 
