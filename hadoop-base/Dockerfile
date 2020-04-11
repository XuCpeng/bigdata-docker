FROM ubuntu:18.04

COPY entrypoint.sh xcall xsync /usr/local/bin/
COPY sources.list /etc/apt/
RUN mkdir /var/run/sshd \
    && apt update && apt install -y ssh rsync curl \
    && echo "root:123123" | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys 

RUN mkdir -p /opt/data/hadoop/name && mkdir /opt/data/hadoop/secondary && mkdir /opt/data/hadoop/data && mkdir /opt/data/hadoop/tmp \
    && curl -o /opt/jdk.tar.gz https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/8/jdk/x64/linux/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz \
    && curl -o /opt/hadoop.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz\
    && mkdir /opt/jdk && mkdir /opt/hadoop \
    && tar -xzf /opt/jdk.tar.gz -C /opt/jdk --strip-components 1 \
    && tar -xzf /opt/hadoop.tar.gz -C /opt/hadoop --strip-components 1 \
    && rm -rf /opt/hadoop.tar.gz && rm -rf /opt/jdk.tar.gz

COPY core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml hadoop-env.sh workers /opt/hadoop/etc/hadoop/

RUN echo "export JAVA_HOME=/opt/jdk" >> /etc/profile.d/jdk_env.sh  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/profile.d/jdk_env.sh  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/jdk_env.sh  \
    && echo "export HADOOP_HOME=/opt/hadoop" >> /etc/profile.d/hadoop_env.sh  \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" >> /etc/profile.d/hadoop_env.sh \
    && echo "export JAVA_HOME=/opt/jdk" >> /etc/bash.bashrc  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/bash.bashrc  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/bash.bashrc  \
    && echo "export HADOOP_HOME=/opt/hadoop" >> /etc/bash.bashrc \
    && echo "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" >> /etc/bash.bashrc \
    && echo "export JAVA_HOME=/opt/jdk" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

CMD ["/usr/sbin/sshd", "-D"]