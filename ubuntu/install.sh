#!/bin/bash
set -e

# enable guest additions on command line 
install_guest_additions() {
  sudo mkdir -p /mnt/cdrom
  sudo mount /dev/cdrom /mnt/cdrom
  cd /mnt/cdrom
  sudo apt-get install bzip2
  sudo sh ./VBoxLinuxAdditions.run
}


provision() {
  install_helm
  add_sudoers
}

install_helm() {
  echo install helm
  sudo apt-get install apt-transport-https --yes
  curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install -y helm
}

add_sudoers() {
  sudo usermod -aG sudo,vboxsf niemimac
}

iptables_legacy_mode() {
  sudo iptables -F
  sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
  sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
  sudo reboot
}

provision
