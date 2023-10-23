#!/bin/bash
set -e

provision() {
  fix_network
  add_sudoers
  install_java
  install_eclipse
  install_lombok
  install_chrome
  install_docker
  install_helm
  install_k9s
}

fix_network() {
  echo add wsl.conf
  echo -e '\n[network]\ngenerateResolvConf = false' >> /etc/wsl.conf
  echo fix resolv.conf
  rm /etc/resolv.conf
  echo -e 'nameserver 8.8.8.8' > /etc/resolv.conf
}

add_sudoers() {
  sudo apt update
  sudo apt install -y nano
  sudo usermod -aG sudo niemimac
  # run command
  # sudo visudo
  # add line
  # niemimac     ALL=(ALL) NOPASSWD:ALL
}

install_java() {
  sudo apt install -y openjdk-17-jre
}

install_eclipse() {
  sudo apt install -y libgtk-3-0
  sudo snap install eclipse --classic
}

install_lombok() {
  mkdir -p /home/niemimac/snap/eclipse/current
  cp /snap/eclipse/current/eclipse.ini /home/niemimac/snap/eclipse/current/eclipse.ini
  chown niemimac -hR /home/niemimac/snap/eclipse/current
  curl https://projectlombok.org/downloads/lombok.jar --output /home/niemimac/lombok.jar
  java -jar /home/niemimac/lombok.jar
}

install_chrome() {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt-get install -y -f
}

# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
install_docker() {
  echo install docker
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt install -y docker-ce
  sudo systemctl status docker
  sudo usermod -G docker -a niemimac
  # edit /lib/systemd/system, add following to ExecStart line
  # -H=tcp://0.0.0.0:2375
  # sudo systemctl daemon-reload
  # sudo service docker restart
}

install_helm() {
  echo install helm
  sudo apt-get install apt-transport-https --yes
  curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install -y helm
}

install_k9s() {
  echo install k9s
  sudo snap install k9s
#  curl -sS https://webinstall.dev/k9s | bash
#  export PATH="/home/niemimac/.local/bin:$PATH"
}

#docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /yourpath:/.config/jesseduffield/lazydocker lazyteam/lazydocker

provision
  