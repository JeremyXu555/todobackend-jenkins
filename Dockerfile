FROM jenkins/jenkins:lts

USER root

ARG DOCKER_GID=497

RUN groupadd -g ${DOCKER_GID:-497} DOCKER

ARG DOCKER_ENGINE=18.06.1-ce
ARG DOCKER_COMPOSE=3.7

RUN apt-get update -y && \
    apt-get install apt-transport-https curl python-dev python-setuptools gcc make libssl-dev -y && \
    easy_install pip

# Install Docker Compose
RUN pip install docker-compose && \
    pip install ansible boto boto3

# Change to jenkins user
USER jenkins

# Add Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt