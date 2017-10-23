FROM java:8
ARG eclversion=oxygen
#ARG eclversion=neon

ADD sudoers /etc/sudoers.d/

ENV ECLIPSE_URL=http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/${eclversion}/R/eclipse-java-${eclversion}-R-linux-gtk-x86_64.tar.gz
RUN mkdir -p /opt && curl $ECLIPSE_URL | tar -xvz -C /opt

##########################################################################
# worker
RUN useradd -u 1000 worker; echo "worker:password" | chpasswd
ADD bashrc /home/worker/.bashrc
RUN mkdir -p /home/worker; chown -R worker:worker /home/worker


EXPOSE 22
CMD ["/opt/eclipse/eclipse"]
