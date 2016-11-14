FROM ubuntu:16.04



RUN apt-get update && apt-get install -y openssh-server nginx

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN rm -rf /var/www/html/index.nginx-debian.html
COPY index.html /var/www/html/index.html
COPY start.sh /usr/local/start.sh

EXPOSE 22 80
CMD ["/bin/bash", "/usr/local/start.sh"]
