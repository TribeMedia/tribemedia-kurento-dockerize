FROM ubuntu:14.04
MAINTAINER Travis James <travis@tribemedia.io>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get autoremove
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN apt-get install -y cmake
RUN apt-get install -y wget
RUN apt-get install -y python2.7 python2.7-dev
RUN apt-get install -y nano

RUN apt-get update && apt-get install -y openssh-server supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir /var/run/sshd
RUN echo 'root:tribemedia' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN echo 'export LANG=C' >> /etc/profile \
 && echo 'export LC_ALL=C' >> /etc/profile

RUN echo $PATH
RUN /usr/bin/python --version
RUN export PATH=$PATH:/usr/bin && git clone https://github.com/joyent/node.git /node && cd /node && git checkout tags/v0.12.7 && ./configure && CXX="g++ -Wno-unused-local-typedefs" make && CXX="g++ -Wno-unused-local-typedefs" make install && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:/usr/local/bin:$PATH"' >> /root/.bashrc
RUN apt-get install -y software-properties-common
RUN cd / && git clone https://github.com/Kurento/kurento-media-server.git && cd kurento-media-server && git checkout 6.0.0 && echo "deb http://ubuntu.kurento.org trusty kms6" | sudo tee /etc/apt/sources.list.d/kurento.list && \
  wget -O - http://ubuntu.kurento.org/kurento.gpg.key | apt-key add - && \
  apt-get -y update && apt-get install -y $(cat debian/control | sed -e "s/$/\!\!/g" | tr -d '\n' | sed "s/\!\! / /g" | sed "s/\!\!/\n/g" | grep "Build-Depends" | sed "s/Build-Depends: //g" | sed "s/([^)]*)//g" | sed "s/, */ /g") && \
  mkdir build && cd build && cmake .. && make -j4 && make install && ln -s /usr/local/bin/kurento-media-server /usr/bin/kurento-media-server
COPY kurento-media-server-docker-6.0 /etc/default/kurento-media-server-docker-6.0
EXPOSE 22 3000 8888 49152-65535/udp
CMD ["/usr/bin/supervisord"]
