set -e

provision() {
  enable_alpine_repositories
  upgrade_alpine
  install_sudo
  install_docker
  echo install docker-compose
  apk add docker-compose 
  echo install kubectl
  apk add kubectl 
  echo install helm
  apk add helm
  echo install maven
  apk add maven 
  echo install jdk
  apk add openjdk8
  install_k3d
  ln -s /mnt/c/Users/marko/Documents/Git/ git
}

enable_alpine_repositories() {
  echo enable alpine repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' > /etc/apk/repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories
}

upgrade_alpine() {
  echo upgrade alpine
  apk upgrade -U -a
}

install_sudo() {
  echo install sudo
  apk add sudo
  chmod u+w /etc/sudoers
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

install_docker() {
  echo install docker
  apk add docker
  addgroup -S niemimac docker
  dockerd &> /dev/null &
  sleep 5
  chown -R root:docker /var/run/docker
}

#install docker-compose as a container, not used anymore
install_docker_compose() {
  # https://docs.docker.com/compose/install/
  DOCKER_COMPOSE_VERSION=1.26.2
  echo 'Installing docker-compose as a container'
  sudo wget https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh -O /usr/local/bin/docker-compose
  #sudo curl -L --fail https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

install_k3d() {
  echo install k3d
  wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | ash
}

provision

