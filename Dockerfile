FROM openjdk:8-jdk-alpine

RUN apk add --no-cache --update python3 \
        #python3-dev \
        git \
        py3-pip 
        #build-base \
        #musl-dev \
        #gfortran \
        #libffi-dev 

RUN pip3 install python-dotenv requests

ADD . /root/

WORKDIR /root
#RUN git clone https://github.com/jenkinsci/jenkins.git

RUN apk add --no-cache --update openjdk8 curl

RUN mkdir /usr/lib/gradle
WORKDIR /usr/lib/gradle
RUN set -x \
  && curl -L -O https://services.gradle.org/distributions/gradle-4.10.3-bin.zip \
  && unzip gradle-4.10.3-bin.zip

ENV PATH ${PATH}:/usr/lib/gradle/gradle-4.10.3/bin

WORKDIR /root/szz

RUN gradle build && gradle fatJar

WORKDIR /root

ENTRYPOINT ["python3", "fetch_jira_bugs/automatisation_commandes.py"]