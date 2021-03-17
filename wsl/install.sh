set -e

provision () {
  enable_alpine_repositories
  upgrade_alpine
  install_sudo
  apk add docker docker-compose kubectl helm
  apk add maven openjdk8
  source install-k3d.sh
}

enable_alpine_repositories() {
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' > /etc/apk/repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
  echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories
}

upgrade_alpine() {
  apk upgrade -U -a
}

install_sudo() {
  apk add sudo
  chmod u+w /etc/sudoers
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

provision
