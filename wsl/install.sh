#!/bin.sh
set -e
source install-docker.sh
source install-docker-compose.sh
#source /home/docker/git/dev-env/wsl/disable-docker-tls.sh

provision () {
#  source ~/.bashrc
  enable_edge
  install_sudo
  install_docker
  install_docker_compose
  #disable_docker_tls
}

enable_edge() {
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' > /etc/apk/repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
}

install_sudo() {
  apk add sudo
  chmod u+w /etc/sudoers
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

provision
