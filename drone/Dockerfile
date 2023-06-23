FROM apache/hadoop:3

RUN sudo yum clean all
RUN sudo yum install -y openssh-server openssh-clients

RUN sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
RUN sudo ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
RUN sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
RUN sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

# "/usr/lib/jvm/java-8-openjdk-amd64/jre"
# ofc you can escape quotes
RUN sudo sh -c "echo PATH=\\\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/hadoop/bin:/opt/hadoop/sbin\\\" >> /etc/environment"
RUN sudo sh -c "echo JAVA_HOME=\\\"/usr/lib/jvm/jre/\\\" >> /etc/environment"

RUN echo hadoop:hadoop | sudo chpasswd
COPY entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh

# edit core site
# $(<inputFile.txt)
# some way to pas in file
# cant output to file. must be a swap problem
COPY core.xml core.xml
RUN sed -i '/<configuration>/ r core.xml' /opt/hadoop/etc/hadoop/core-site.xml

COPY hdfs.xml hdfs.xml
RUN sed -i '/<configuration>/ r hdfs.xml' /opt/hadoop/etc/hadoop/hdfs-site.xml

RUN echo drone-1 /opt/hadoop/etc/hadoop/workers
RUN echo drone-2 /opt/hadoop/etc/hadoop/workers

COPY yarn.xml yarn.xml
RUN sed -i '/<configuration>/ r yarn.xml' /opt/hadoop/etc/hadoop/yarn-site.xml

EXPOSE 22

ENTRYPOINT [ "/entrypoint.sh" ]