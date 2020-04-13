FROM ubuntu:18.04

COPY sources.list /etc/apt/
RUN mkdir /var/run/sshd \
    && apt update && apt install -y ssh rsync curl\
    && echo "root:123123" | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys 

RUN curl -o /opt/jdk.tar.gz https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/8/jdk/x64/linux/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz \
    && curl -o /opt/spark.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz\
    && mkdir /opt/spark && mkdir /opt/jdk \
    && tar -xzf /opt/jdk.tar.gz -C /opt/jdk --strip-components 1 \
    && tar -xzf /opt/spark.tar.gz -C /opt/spark --strip-components 1 \
    && rm -rf /opt/spark.tar.gz && rm -rf /opt/spark.tar.gz

COPY slaves spark-env.sh spark-defaults.conf /opt/spark/conf/

RUN echo "export JAVA_HOME=/opt/jdk" >> /etc/profile.d/jdk_env.sh  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/profile.d/jdk_env.sh  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile.d/jdk_env.sh  \
    && echo "export JAVA_HOME=/opt/jdk" >> /etc/bash.bashrc  \
    && echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/bash.bashrc  \
    && echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/bash.bashrc \
    && echo "export JAVA_HOME=/opt/jdk" >> /opt/spark/conf/spark-env.sh

COPY entrypoint.sh xcall xsync /usr/local/bin/
CMD ["/usr/sbin/sshd", "-D"]