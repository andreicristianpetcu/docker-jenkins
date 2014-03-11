FROM ubuntu:12.04
MAINTAINER Allan Espinosa "allan.espinosa@outlook.com"

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get -y install python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update && apt-get clean
RUN apt-get -y upgrade
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y git emacs23-nox openssh-server sudo pwgen && apt-get clean
RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers
RUN chmod 755 /start.sh
ADD http://mirrors.jenkins-ci.org/war/1.553/jenkins.war /opt/jenkins.war
RUN ln -sf /jenkins /root/.jenkins
RUN mkdir /var/log/supervisor/
RUN mkdir /var/run/sshd
RUN update-alternatives --display java 
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
EXPOSE 22
VOLUME ["/jenkins"]
CMD [""]
CMD ["/bin/bash", "/start.sh"]