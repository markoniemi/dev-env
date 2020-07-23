install_docker_compose () {

DOCKER_COMPOSE_VERSION=1.21.2
# https://docs.docker.com/compose/install/
echo 'Installing docker-compose as a container'
sudo curl -L --fail https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

}

install_docker_compose
