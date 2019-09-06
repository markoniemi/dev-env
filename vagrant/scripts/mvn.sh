docker run \
-it --rm \
-v "$PWD":/usr/src \
-v "$HOME/.m2":/root/.m2 \
-w /usr/src \
maven:3.3-jdk-8 \
mvn $*
