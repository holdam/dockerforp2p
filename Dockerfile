FROM morganic/p2p:latest

# TODO this needs to be done from the folder on docker
# docker build --no-cache -t img .

# TODO need machine's IP here and rememebr to change own IP
# docker run --cap-add=NET_ADMIN -p 15000:15000 -p 15001:15001 -p 15002:15002/udp -e PORT=15000 -e BANDWIDTH=4 -e OWN_IP=192.168.43.1 -e STATISTICS_SERVER=192.168.43.1 img
# docker run --cap-add=NET_ADMIN -p 15003:15003 -p 15004:15004 -p 15005:15005/udp -e PORT=15003 -e BANDWIDTH=4 -e OWN_IP=192.168.43.1 -e STATISTICS_SERVER=192.168.43.1 img

# Update repo
RUN git -C /usr/thesis/ pull

# Compile and run
RUN mvn install -f /usr/thesis/pom.xml -DskipTests
RUN mvn -f /usr/thesis/pom.xml dependency:copy-dependencies -DincludeScope=runtime

ENTRYPOINT su root /usr/pumba/server.sh