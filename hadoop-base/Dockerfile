FROM ubuntu:18.04

RUN mkdir /var/run/sshd \
    && mkdir -p /opt/data/hadoop/name \
    && mkdir /opt/data/hadoop/secondary && mkdir /opt/data/hadoop/data && mkdir /opt/data/hadoop/tmp \
    && apt update && apt install -y ssh rsync \
    && echo "root:123123" | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys 

ADD  hadoop-3.2.1.tar.gz jdk-8u241-linux-x64.tar.gz /opt/
COPY entrypoint.sh xcall xsync /usr/local/bin/
COPY core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml hadoop-env.sh workers /opt/hadoop-3.2.1/etc/hadoop/

RUN echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /etc/profile.d/jdk_env.sh  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/profile.d/jdk_env.sh  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/jdk_env.sh  \
    && echo "export HADOOP_HOME=/opt/hadoop-3.2.1" >> /etc/profile.d/hadoop_env.sh  \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" >> /etc/profile.d/hadoop_env.sh \
    && echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /etc/bash.bashrc  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/bash.bashrc  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/bash.bashrc  \
    && echo "export HADOOP_HOME=/opt/hadoop-3.2.1" >> /etc/bash.bashrc \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" >> /etc/bash.bashrc \
    && echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /opt/hadoop-3.2.1/etc/hadoop/hadoop-env.sh

CMD ["/usr/sbin/sshd", "-D"]