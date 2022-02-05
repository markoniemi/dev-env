#!/bin/bash
set -e

# bash < <(curl -s https://raw.githubusercontent.com/markoniemi/dev-env/master/ubuntu/install_guest_additions.sh) 

# enable guest additions on command line 
  sudo apt update
  sudo mkdir -p /mnt/cdrom
  sudo mount /dev/cdrom /mnt/cdrom
  cd /mnt/cdrom
  sudo apt-get install bzip2
  sudo sh ./VBoxLinuxAdditions.run
  sudo usermod -G vboxsf -a niemimac
  sudo reboot
# add a shared folder after reboot
