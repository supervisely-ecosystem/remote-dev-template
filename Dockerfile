ARG IMAGE
ARG PASS
FROM $IMAGE

RUN apt-get update && apt-get install -y openssh-server
RUN ssh-keygen -A
RUN mkdir -p /run/sshd

RUN echo 'root:debug' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# # SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY sshd_deamon.sh /sshd_deamon.sh
RUN chmod 755 /sshd_deamon.sh

CMD ["/sshd_deamon.sh"]
ENTRYPOINT ["sh", "-c", "/sshd_deamon.sh"]