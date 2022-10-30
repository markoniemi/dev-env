set -e

provision() {
  fix_network
  fix_wsl
  enable_alpine_repositories
  upgrade_alpine
  install_sudo
#  add_user
  install_docker
  echo install docker-compose
  apk add docker-compose 
  echo install curl
  apk add curl
#  echo install kubectl
#  apk add kubectl 
#  echo install helm
#  apk add helm
  echo install maven
  apk add maven 
  echo install jdk
  apk add openjdk11
#  install_k3d
  install_k3s
  install_k9s
  ln -s /mnt/c/Users/marko/Documents/Git/ git
}

fix_network() {
  echo add wsl.cof
  echo -e '[network]\ngenerateResolvConf = false' > /etc/wsl.conf
  echo fix resolv.conf
  rm /etc/resolv.conf
  echo -e 'nameserver 8.8.8.8' > /etc/resolv.conf
}

fix_wsl() {
  #these commands are executed by ms Alpine after install
  /bin/chmod 755 /
  /sbin/apk --no-cache add shadow
  /sbin/apk --no-cache add alpine-base
  /bin/sed -i 's/^export PATH/#export PATH/' /etc/profile
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
#  addgroup -S niemimac docker
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

install_k3s() {
  echo install k3s
  curl -sfL https://get.k3s.io | sudo sh -
#  sudo apk add k3s
#  curl -O -fsSL https://github.com/k3s-io/k3s/releases/download/v1.24.1%2Bk3s1/k3s
#  mv k3s /usr/bin/k3s
#  chmod a+x /usr/bin/k3s
}

install_k9s() {
  curl -O -fsSL https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz
  tar x -f k9s_Linux_x86_64.tar.gz -C /usr/local/bin/
}
provision
