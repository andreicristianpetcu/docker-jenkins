FROM ubuntu:14.04
MAINTAINER Bjørn Magnus Mathisen <bjornmagnus@me.com>
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install python-software-properties software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update && apt-get clean
RUN apt-get -y upgrade
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y git emacs23-nox vim openssh-server sudo && apt-get clean
ADD http://mirrors.jenkins-ci.org/war/1.553/jenkins.war /opt/jenkins.war
RUN ln -sf /jenkins /root/.jenkins
RUN mkdir /var/run/sshd
RUN update-alternatives --display java 
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

EXPOSE 8080
EXPOSE 22
VOLUME ["/jenkins"]
CMD ["/bin/bash", "/start.sh"]
