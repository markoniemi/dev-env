#!/bin.sh
source /home/docker/git/dev-env/vagrant/install-docker-compose.sh
source /home/docker/git/dev-env/vagrant/disable-docker-tls.sh

provision () {
#  source ~/.bashrc
  install_docker_compose
  disable_docker_tls
}
