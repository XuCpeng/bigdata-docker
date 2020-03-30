FROM ubuntu:18.04

ADD  ../Downloads/spark-3.0.0-preview2-bin-hadoop3.2.tgz ../Downloads/jdk-8u241-linux-x64.tar.gz /opt/
COPY xcall xsync /usr/local/bin/
COPY slaves spark-env.sh spark-defaults.conf /opt/spark-3.0.0-preview2-bin-hadoop3.2/conf/

RUN mkdir /var/run/sshd \
    && apt update && apt install -y ssh rsync \
    && echo "root:123123" | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys 

RUN echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /etc/profile.d/jdk_env.sh  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/profile.d/jdk_env.sh  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/jdk_env.sh  \
    && echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /etc/bash.bashrc  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/bash.bashrc  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/bash.bashrc \
    && echo "export JAVA_HOME=/opt/jdk1.8.0_241" >> /opt/spark-3.0.0-preview2-bin-hadoop3.2/conf/spark-env.sh

CMD ["/usr/sbin/sshd", "-D"]