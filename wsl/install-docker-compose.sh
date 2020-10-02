# https://docs.docker.com/compose/install/
DOCKER_COMPOSE_VERSION=1.26.2
echo 'Installing docker-compose as a container'
sudo wget https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh -O /usr/local/bin/docker-compose
#sudo curl -L --fail https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/run.sh -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
