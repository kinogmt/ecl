FROM quay.io/cloudian/centos-ssh:7-jdk8
#ARG eclversion=oxygen
ARG eclversion=neon

RUN yum install -y git gtk3

ADD sudoers /etc/sudoers.d/

ENV ECLIPSE_URL='http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/${ARG}/R/eclipse-java-${ARG}-R-linux-gtk-x86_64.tar.gz'
RUN mkdir -p /opt && curl $ECLIPSE_URL | tar -xvz -C /opt

##########################################################################
# worker
RUN (useradd -u 1000 worker; echo "worker:password" | chpasswd; \
     mkdir -p /var/log/cloudian; chown worker:worker /var/log/cloudian)

ADD bashrc /home/worker/.bashrc


EXPOSE 22
CMD ["/opt/eclipse/eclipse"]
