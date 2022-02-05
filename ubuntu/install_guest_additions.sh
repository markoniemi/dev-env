#!/bin/bash
set -e

# wget -O https://raw.githubusercontent.com/markoniemi/dev-env/master/ubuntu/install_guest_additions.sh | bash 

# enable guest additions on command line 
install_guest_additions() {
  sudo apt update
  sudo mkdir -p /mnt/cdrom
  sudo mount /dev/cdrom /mnt/cdrom
  cd /mnt/cdrom
  sudo apt-get install bzip2
  sudo sh ./VBoxLinuxAdditions.run
  sudo usermod -G vboxsf -a niemimac
  sudo reboot
# add a shared folder after reboot
}
