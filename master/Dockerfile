FROM apache/hadoop:3

RUN sudo yum clean all
RUN sudo yum install -y openssh-server openssh-clients

RUN sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
RUN sudo ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
RUN sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
RUN sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

COPY ssh.yes ssh.yes
RUN ssh-keygen < ssh.yes
RUN cat /opt/hadoop/.ssh/id_rsa.pub >> /opt/hadoop/.ssh/authorized_keys

RUN echo hadoop:hadoop | sudo chpasswd
RUN echo root:toor | sudo chpasswd

# "/usr/lib/jvm/java-8-openjdk-amd64/jre"
# ofc you can escape quotes
RUN sudo sh -c "echo PATH=\\\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/hadoop/bin:/opt/hadoop/sbin\\\" >> /etc/environment"
RUN sudo sh -c "echo JAVA_HOME=\\\"/usr/lib/jvm/jre/\\\" >> /etc/environment"

COPY entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh

# edit sites
# $(<inputFile.txt)
# some way to pas in file
# cant output to file. must be a swap problem
# cant find end tag, forgot how. this quicker. need r and i
COPY core.xml core.xml
RUN sed -i '/<configuration>/ r core.xml' /opt/hadoop/etc/hadoop/core-site.xml

COPY hdfs.xml hdfs.xml
RUN sed -i '/<configuration>/ r hdfs.xml' /opt/hadoop/etc/hadoop/hdfs-site.xml

RUN echo drone-1 /opt/hadoop/etc/hadoop/workers
RUN echo drone-2 /opt/hadoop/etc/hadoop/workers

# run setup
# this stops it from hanging
# RUN hdfs
RUN hdfs namenode -format

EXPOSE 22
EXPOSE 9870
EXPOSE 8088

ENTRYPOINT [ "/entrypoint.sh" ]