ARG IMAGE
FROM $IMAGE

RUN apt-get update && apt-get install -y openssh-server
EXPOSE 22

#RUN apt-get install sudo -y
#RUN mkdir -p /run/sshd

# Create a group and user account for the SSH connection
#RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
#RUN usermod -aG sudo sshuser

# NOT RECOMMENDED: Set a password on the sshuser account
# RUN echo 'sshuser:Pa$$word' | chpasswd

# MORE SECURE: use a trusted RSA key
#ARG home=/home/sshuser
#RUN mkdir $home/.ssh
COPY id_rsa.pub ~/.ssh/authorized_keys
RUN chown root:root $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys

COPY sshd_deamon.sh /sshd_deamon.sh
RUN chmod 755 /sshd_deamon.sh
CMD ["/sshd_deamon.sh"]
ENTRYPOINT ["sh", "-c", "/sshd_deamon.sh"]