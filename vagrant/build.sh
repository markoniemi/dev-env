docker run \
-it --rm \
maven:3.3-jdk-8 \
mvn clean package

#-v "$PWD":/usr/src/mymaven \
#-v "$HOME/.m2":/root/.m2 \
#-v "$PWD/target:/usr/src/mymaven/target" \
#-w /usr/src/mymaven maven \
